module Rpush
  module Daemon
    module Apns
      extend ServiceConfigMethods

      HOSTS = {
        # production: ['api.push.apple.com', 443],
        # development: ['api.sandbox.push.apple.com', 443], # deprecated
        # sandbox: ['api.sandbox.push.apple.com', 443]
        production: 'https://api.push.apple.com:443',
        development: 'https://api.sandbox.push.apple.com:443',
        sandbox: 'https://api.sandbox.push.apple.com:443'        
      }

      batch_deliveries true
      dispatcher :apns_tcp, host: proc { |app| HOSTS[app.environment.to_sym] }
      loops Rpush::Daemon::Apns::FeedbackReceiver, if: -> { Rpush.config.apns.feedback_receiver.enabled && !Rpush.config.push }
    end
  end
end
