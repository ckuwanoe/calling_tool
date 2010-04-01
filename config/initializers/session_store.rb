# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :domain      => '.roryreid.com',
  :key         => '_rory_reid_session',
  :secret      => '379e38153b987797c402bb9d26d0fcd3667ac117b7f9b46c4e1b191d70ab7b4b7636b8c50a4ff29df3bc7698c8928c4813539c584d341e412c6f448de19c6d98'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
