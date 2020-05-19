#
# Be sure to run `pod lib lint LMVVehicleServiceForLeapMotor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FGExtensionSDK'
  s.version          = '##PackageTag##'
  s.summary          = 'A short description of FGExtensionSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/flamegrace/FGExtensionSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'flamegrace' => 'flamegrace@hotmail.com' }
  s.source           = { :git => '##PackageSourcePath##', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = "FGExtensionSDK","Classes/**/*.{h,m,plist,cfg,jet,cpp,mm}"
  s.public_header_files = 'Classes/Headers/**/*.h'

  s.prefix_header_contents = '#import "FGPrefixHeader.h"'

  s.frameworks = "UIKit"
  s.library = "c++"
  s.vendored_libraries = 'Classes/**/*.a'
  s.vendored_frameworks = 'Classes/**/*.framework'
  s.dependency "FGFoundationSDK"
  
end
