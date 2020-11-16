# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'nasaapp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for nasaapp
  #Reactive
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Moya/RxSwift', '~> 14.0'
  #Image Cache
  pod 'SDWebImage', '~> 5.0'

  target 'nasaappTests' do
    inherit! :search_paths
    pod 'Nimble'
    pod 'Nimble-Snapshots'
    pod 'Quick'
  end

  target 'nasaappUITests' do
    pod 'KIF', :configurations => ['Debug']
  end

end
