Pod::Spec.new do |s|
  s.name             = "OCNotificationBar"
  s.version          = "0.1"
  s.summary          = "Slack Notification Bar clone attempt"
  s.homepage         = "https://github.com/flavionegrao/OCNotificationBar"
  s.license          = 'MIT'
  s.author           = { "Flavio Negrao Torres" => "flavio@omni.chat" }

  s.source           = { :git => "https://github.com/flavionegrao/OCNotificationBar.git", :tag => "#{s.version}" }
  s.source_files     = "OCNotificationBar/**"

  s.ios.deployment_target = '8.3'
  s.requires_arc = true

end