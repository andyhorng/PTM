# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_part_time_money_session',
  :secret      => 'a7fcd9ed3bd53f7209ec6db660d3145dca865a2b5981dffe769f959f2d3be67cda56248cb6a16aaf8b106a7181e72fea9a845f2ad550f4c6c3335b07cf6edbc3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
