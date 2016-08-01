
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

# Pods for MaxRep

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end


target 'MaxRep' do
    pod 'RealmSwift’
    pod 'ChameleonFramework/Swift'
	
    target 'MaxRepTests' do
	inherit! :search_paths
    	testing_pods
    end

    target 'MaxRepUITests' do
	inherit! :search_paths
       testing_pods
    end
end

