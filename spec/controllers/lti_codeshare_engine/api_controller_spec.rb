require 'spec_helper'

module LtiCodeshareEngine
  describe ApiController do

   describe "POST create_entry_from_url" do
      it "with valid JSBIN url" do
        post :create_entry_from_url, url: "http://jsbin.com/eVIyOTE/3/edit", use_route: :lti_codeshare_engine
        expect(response.status).to be(201)

        json = JSON.parse(response.body)
        expect(json['klass']).to eq('FiddleFart::Jsbin')
        expect(json['remote_id']).to eq('eVIyOTE')
        expect(json['revision']).to eq(3)
      end
    end

  end
end
