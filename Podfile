# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'

target 'FourSquare' do
    use_frameworks!
    
    # Networking
    pod 'Alamofire', '4.0'
    
    # Database
    pod 'Realm', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', submodules: true
    pod 'RealmSwift', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', submodules: true
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
    
    # GoogleMaps
    pod 'GoogleMaps', '2.1.1'
    pod 'GooglePlaces', '2.1.1'
    pod 'GooglePlacePicker', '2.1.1'
    
    # UI
    pod 'PageMenu', '1.2.9'
    pod 'SVProgressHUD', '2.1.2'
    
    # Utils
    pod 'ObjectMapper', '2.2'
    
    target 'FourSquareTests' do
        
    end
    
    target 'FourSquareUITests' do
        
    end
    
end
