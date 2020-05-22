if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_bikez", domain: "https://api.bikenumbers.dev", tld_length: 2
else
  Rails.application.config.session_store :cookie_store, key: "_bikez"
end