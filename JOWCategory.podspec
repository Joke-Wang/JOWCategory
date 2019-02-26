Pod::Spec.new do |s|
  s.name             = 'JOWCategory'
  s.version          = '0.1.3'
  s.summary          = 'Summary of functions used in development.'
  s.description      = <<-DESC
  JOWCategory is my Summary of functions used in development.
                       DESC

  s.homepage         = 'https://github.com/Joke-Wang/JOWCategory'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joke-Wang' => 'wangzhangzhong1102@163.com' }
  s.source           = { :git => 'https://github.com/Joke-Wang/JOWCategory.git', :tag => s.version.to_s }
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JOWCategory/Classes/**/*'
  s.public_header_files = 'JOWCategory/Classes/JOWCategory.h'
  
  # s.resource_bundles = {
  #   'JOWCategory' => ['JOWCategory/Assets/*.png']
  # }

  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  
  s.subspec 'JOWFoundation' do |ss|
      ss.source_files = 'JOWCategory/Classes/JOWFoundation/*.{h,m}'
      ss.public_header_files = 'JOWCategory/Classes/JOWFoundation/JOWFoundation.h'
  end
  
  s.subspec 'JOWStringCategory' do |ss|
      ss.source_files = 'JOWCategory/Classes/JOWFoundation/NSString+ZZ.{h,m}'
      ss.public_header_files = 'JOWCategory/Classes/JOWFoundation/NSString+ZZ.h'
  end
  
  s.subspec 'JOWUIKit' do |ss|
      ss.source_files = 'JOWCategory/Classes/JOWUIKit/*.{h,m}'
      ss.public_header_files = 'JOWCategory/Classes/JOWUIKit/*.h'
      ss.dependency 'JOWCategory/JOWStringCategory'
  end
  
  s.subspec 'JOWQRCode' do |ss|
      ss.source_files = 'JOWCategory/Classes/JOWQRCode/UIImage+QRCode.{h,m}'
      ss.public_header_files = 'JOWCategory/Classes/JOWQRCode/UIImage+QRCode.h'
  end
  
end
