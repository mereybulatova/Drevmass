# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Drevmass' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Drevmass
    pod 'SnapKit'
    pod 'AdvancedPageControl'
    pod 'Alamofire'
    pod 'SDWebImage'
    pod 'SwiftyJSON'
    pod 'SVProgressHUD'
    pod 'YouTubePlayer'

# Setup target iOS version for all pods after install
post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
  end
end

end
