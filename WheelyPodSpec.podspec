#
#  Be sure to run `pod spec lint WheelyPodSpec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "WheelyPodSpec"
s.summary = "WheelyPodSpec bla bla"
s.requires_arc = true
s.version = "0.1.3"
s.license = { :type => "MIT", :file => "LICENSE" }


s.author = { "Artem Martirosyan" => "martiros.artem@gmail.com" }
s.homepage = "https://github.com/ArtMartiros/WheelyPodSpec.git"
s.source = { :git => "https://github.com/ArtMartiros/WheelyPodSpec.git", 
             :tag => "#{s.version}" }

s.framework = "UIKit"
s.source_files = "WheelyPodSpec/**/*.{swift}"
s.resources = "WheelyPodSpec/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
s.swift_version = "4.2"

end

