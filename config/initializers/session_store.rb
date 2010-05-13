# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_faulkner_at_heroku_session',
  :secret      => '3eb668ec91a2a9527559882cfaecb6c1c8084509b7510165295b7db1cfb160cd08ddd2d9714a0baec6e9eeed65aed0e6b22dc8536f925dbcaeac41bd2da9b8f1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
