Pod::Spec.new do |s|
  s.name = "JOWCategory"
  s.version = "0.1.7"
  s.summary = "Summary of functions used in development."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Joke-Wang"=>"wangzhangzhong1102@163.com"}
  s.homepage = "https://github.com/Joke-Wang/JOWCategory"
  s.description = "JOWCategory is my Summary of functions used in development."
  s.frameworks = ["UIKit", "Foundation"]
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/JOWCategory.framework'
end
