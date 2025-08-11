# app/controllers/tracking_links_controller.rb

class TrackingLinksController < ApplicationController
  def create
    # Create client
    client = AirbridgeDeeplink::Client.new

    # Parameters for tracking link
    options = {
      channel: params[:channel],
      campaignParams: {
        campaign: params[:campaign],
        ad_group: params[:ad_group],
        ad_creative: params[:ad_creative]
      },
      isReengagement: params[:is_reengagement] || "OFF-FALSE",
      deeplinkOption: {
        showAlertForInitialDeeplinkingIssue: params[:show_alert] || false
      }
    }

    # Add fallback paths if specified
    if params[:ios_custom_product_page_id] || params[:google_play_custom_store_listing]
      options[:fallbackPaths] = {
        option: {
          iosCustomProductPageId: params[:ios_custom_product_page_id],
          googlePlayCustomStoreListing: params[:google_play_custom_store_listing]
        }.compact
      }
    end

    # Add OG tags if specified
    if params[:og_title] || params[:og_description] || params[:og_image_url]
      options[:ogTag] = {
        title: params[:og_title],
        description: params[:og_description],
        imageUrl: params[:og_image_url]
      }.compact
    end

    begin
      # Create tracking link
      response = client.create_tracking_link(options)

      render json: {
        success: true,
        tracking_link: response
      }
    rescue AirbridgeDeeplink::ConfigurationError => e
      render json: {
        success: false,
        error: "Configuration error: #{e.message}"
      }, status: :internal_server_error
    rescue AirbridgeDeeplink::APIError => e
      render json: {
        success: false,
        error: "API error: #{e.message}"
      }, status: :bad_request
    rescue ArgumentError => e
      render json: {
        success: false,
        error: "Invalid parameters: #{e.message}"
      }, status: :unprocessable_entity
    rescue => e
      render json: {
        success: false,
        error: "Unexpected error: #{e.message}"
      }, status: :internal_server_error
    end
  end

  private

  def tracking_link_params
    params.permit(
      :channel, :campaign, :ad_group, :ad_creative, :is_reengagement,
      :show_alert, :ios_custom_product_page_id, :google_play_custom_store_listing,
      :og_title, :og_description, :og_image_url
    )
  end
end