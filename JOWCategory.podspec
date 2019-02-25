#
# Be sure to run `pod lib lint JOWCategory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JOWCategory'
  s.version          = '0.1.1'
  s.summary          = 'Summary of functions used in development.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  JOWCategory is my Summary of functions used in development.
                       DESC

  s.homepage         = 'https://github.com/Joke-Wang/JOWCategory'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joke-Wang' => 'wangzhangzhong1102@163.com' }
  s.source           = { :git => 'https://github.com/Joke-Wang/JOWCategory.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JOWCategory/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JOWCategory' => ['JOWCategory/Assets/*.png']
  # }

   s.public_header_files = 'Pod/Classes/*.h'
   s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  
  s.subspec 'JOWFoundation' do |ss|
      ss.source_files = 'JOWCategory/Classes/Foundation+ZZCategory/*.{h/m}'
  end
  
  s.subspec 'JOWUIKit' do |ss|
      ss.source_files = 'JOWCategory/Classes/UIKit+ZZCategory/*.{h/m}'
  end
  
  s.subspec 'JOWQRCode' do |ss|
      ss.source_files = 'JOWCategory/Classes/**/UIImage+QRCode.{h,m}'
  end
  
end
