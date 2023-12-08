# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

# Comment the next line if you don't want to use dynamic frameworks

use_frameworks!

workspace 'Fodamy'

target 'Fodamy' do

 project 'Fodamy.xcodeproj'

  # Pods for Fodamy
  
  # Network
  pod 'Alamofire'
  
  # Helper
  pod 'MobilliumUserDefaults', '~> 2.0'
  pod 'KeychainSwift'
  pod 'SKPhotoBrowser'
  pod 'IQKeyboardManagerSwift'
  pod 'MobilliumBuilders'
  pod 'Kingfisher'
  pod 'SwiftEntryKit'
  pod 'TinyConstraints'
  pod 'Segmentio'

  target 'FodamyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FodamyUITests' do
    # Pods for testing
  end

end

target 'DataProvider' do
  
  project 'DataProvider/DataProvider.xcodeproj'
  
  # Pods for DataProvider
  
  # Network
  pod 'Alamofire'
  
  
  target 'DataProviderTests' do
    inherit! :search_paths
    # Pods for testing    
  end
  
end

target 'UIComponents' do

  project 'UIComponents/UIComponents.xcodeproj'
  
  # Pods for UIComponents
  
  # Helper
  pod 'SwiftGen'
  pod 'SwiftEntryKit'
  pod 'MobilliumBuilders'
  pod 'TinyConstraints'
  pod 'Kingfisher'
  pod 'Segmentio'
    
  target 'UIComponentsTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
end

target 'Utilities' do
  
  project 'Utilities/Utilities.xcodeproj'
  
  # Pods for Utilities
  
  # Helper
  pod 'MobilliumUserDefaults', '~> 2.0'
   
  target 'UtilitiesTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
