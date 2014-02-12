require_dependency "lti_codeshare_engine/application_controller"

require "ims/lti"

module LtiCodeshareEngine
  class LtiController < ApplicationController
    def index
      @launch_params = params.reject!{ |k,v| ['controller','action'].include? k }
      @env = {
        launch_params: @launch_params.to_json,
        root_url: root_url,
        root_path: root_path
      }
    end

    def iframe
      @entry = Entry.where(uuid: params[:uuid]).first
      @embed_url = @entry.embed_url.present? ? @entry.embed_url : @entry.share_link
      render layout: false
    end

    def launch
      url = params[:url]
      if url && url =~ /\Ahttps?:\/\/.+\..+\Z/
        redirect_to url
      else
        head 500
      end
    end

    def embed
      @entry = Entry.where(uuid: params[:uuid]).first
      launch_params = JSON.parse(params[:launch_params] || "{}")

      tp = IMS::LTI::ToolProvider.new(nil, nil, launch_params)
      tp.extend IMS::LTI::Extensions::Content::ToolProvider

      @title = "CodeShare"
      @url = iframe_url(@entry.uuid)
      @width = 500
      @height = 600

      redirect_url = build_url(tp, @title, @url, @width, @height)

      if redirect_url.present?
        render json: { redirect_url: redirect_url }, status: 200
      else
        render json: { title: @title, url: @url }, status: 422
      end
    end

    def xml_config
      host = "#{request.protocol}#{request.host_with_port}"
      url = "#{host}#{root_path}"
      title = "CodeShare"
      tool_id = "lti_codeshare_engine"
      tc = IMS::LTI::ToolConfig.new(:title => title, :launch_url => url)
      tc.extend IMS::LTI::Extensions::Canvas::ToolConfig
      tc.description = "Embed code from jsbin, jsfiddle, codepen or plnkr"
      tc.canvas_privacy_anonymous!
      tc.canvas_domain!(request.host)
      tc.canvas_icon_url!("#{host}/assets/lti_codeshare_engine/icon.png")
      tc.canvas_text!(title)
      tc.set_ext_param('canvas.instructure.com', :tool_id, tool_id)
      tc.canvas_editor_button!(enabled: true)
      tc.canvas_resource_selection!(enabled: true)
      render xml: tc.to_xml
    end

    def health_check
      head 200
    end

    private

    def build_url(tp, title, url, width, height)
      if tp.accepts_content?
        redirect_url = nil
        if tp.accepts_iframe?
          redirect_url = tp.iframe_content_return_url(url, width, height, title)
        elsif tp.accepts_url?
          redirect_url = tp.url_content_return_url(url, title, title)
        elsif tp.accepts_lti_launch_url?
          redirect_url = tp.lti_launch_content_return_url(url, title, title)
        end
        return redirect_url
      end
    end
  end
end
