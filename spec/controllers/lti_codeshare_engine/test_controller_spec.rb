require 'spec_helper'

module LtiCodeshareEngine
  describe TestController do

    describe "GET 'backdoor'" do
      it "returns http success" do
        get 'backdoor', use_route: :lti_codeshare_engine
        response.should be_success
      end
    end

  end
end
