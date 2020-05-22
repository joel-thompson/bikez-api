if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_bikez", domain: "https://bikez-api.herokuapp.com"
else
  Rails.application.config.session_store :cookie_store, key: "_bikez"
end