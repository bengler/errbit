# Be sure to restart your server when you modify this file.

Errbit::Application.config.session_store :cookie_store, {
  :key => '_errbit_session',
  :expire_after => 365 * 24 * 60 * 60,
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Errbit::Application.config.session_store :active_record_store

