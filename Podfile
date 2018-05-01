source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

#
# ============================= Pie Driver ==================================
#

def pod_driver_required

    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'Action'
    pod 'RxOptional'
end

# Pie Drive
target 'VehicleCheck' do

    pod_driver_required
end

post_install do |installer|

    # This a workaround for IBDesignables not rendering
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
        config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = [
        '$(FRAMEWORK_SEARCH_PATHS)'
        ]
    end
end
