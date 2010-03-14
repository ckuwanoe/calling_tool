# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_callingtool_session',
  :secret      => '57bc75443d78d231402f8d0e80a77e61e456d98df73abcc19db8ea45bd3f74276ec38904ae6a85c13e3a95166646d506e2408efe243add7d4d885c63cb205ba2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
