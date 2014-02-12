require 'spec_helper'

module LtiCodeshareEngine
  describe LtiController do

    describe "GET 'index'" do
      it "returns http success" do
        get 'index', use_route: :lti_codeshare_engine
        response.should be_success
      end
      describe "GET config" do
        it "should generate a valid xml cartridge" do
          request.stub(:env).and_return({
            "SCRIPT_NAME"     => "/lti_codeshare_engine",
            "rack.url_scheme" => "http",
            "HTTP_HOST"       => "test.host",
            "PATH_INFO"       => "/lti_codeshare_engine"
          })
          get 'xml_config', use_route: :lti_codeshare_engine
          expect(response.body).to include('<blti:title>Lti Codeshare Engine</blti:title>')
          expect(response.body).to include('<blti:description>[description goes here]</blti:description>')
          expect(response.body).to include('<lticm:property name="text">Lti Codeshare Engine</lticm:property>')
          expect(response.body).to include('<lticm:property name="tool_id">lti_codeshare_engine</lticm:property>')
          expect(response.body).to include('<lticm:property name="icon_url">http://test.host/assets/lti_codeshare_engine/icon.png</lticm:property>')


          expect(response.body).to include('<lticm:options name="editor_button">')
          expect(response.body).to include('<lticm:options name="resource_selection">')

        end
      end
    end

  end
end
