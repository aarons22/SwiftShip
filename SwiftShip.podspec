# Be sure to run `pod lib lint SwiftShip.podspec' to ensure this is a
# valid spec before submitting.
Pod::Spec.new do |s|
  s.name             = 'SwiftShip'
  s.version          = '0.1.0'
  s.summary          = 'A toolbelt for interacting with shipping APIs.'
  s.description      = <<-DESC
  Make interacting with shipping APIs (USPS, UPS, FedEx) easier by provding simple methods
  for calculating shipping rates.
                       DESC
  s.homepage         = 'https://github.com/aarons22/SwiftShip'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aaron Sapp' => 'repo@aaron-sapp.space' }
  s.source           = { :git => 'https://github.com/aarons22/SwiftShip.git', :tag => "v#{s.version}" }
  s.social_media_url = 'https://twitter.com/aaronsapp'
  s.ios.deployment_target = '9.0'
  s.source_files = 'SwiftShip/Classes/**/*'
  s.dependency 'Alamofire'
end
