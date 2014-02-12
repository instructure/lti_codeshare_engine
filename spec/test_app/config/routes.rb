Rails.application.routes.draw do

  mount LtiCodeshareEngine::Engine => "/lti_codeshare_engine"
end
