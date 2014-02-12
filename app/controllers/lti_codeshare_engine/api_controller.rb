require_dependency "lti_codeshare_engine/application_controller"

module LtiCodeshareEngine
  class ApiController < ApplicationController

    def create_entry_from_url
      url = params[:url]
      entry = Entry.new_from_url(url)
      if entry && entry.save
        render json: entry, status: 201
      else
        puts "Did not save entry!!!"
        render json: { error: "Invalid URL" }, status: 422
      end
    end

  end
end
