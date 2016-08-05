abstract_target 'MaterialMotionTransitions' do
  pod 'MaterialMotionTransitions', :path => './'

  pod 'MaterialMotionCoreAnimationFamily' , :git => 'https://github.com/material-motion/material-motion-family-coreanimation-swift', :branch => 'develop'

  # To depend on the latest release
  #pod 'MaterialMotionRuntime'

  # To depend on the bleeding edge
  pod 'MaterialMotionRuntime' , :git => 'https://github.com/material-motion/material-motion-runtime-objc.git', :branch => 'develop'

  # To depend on a local modification to the runtime
  #pod 'MaterialMotionRuntime' , :git => '/path/to/runtime-objc', :branch => 'develop'

  workspace 'MaterialMotionTransitions.xcworkspace'
  use_frameworks!

  target "Catalog" do
    project 'examples/apps/Catalog/Catalog.xcodeproj'
  end

  target "UnitTests" do
    project 'examples/apps/Catalog/Catalog.xcodeproj'
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |configuration|
        configuration.build_settings['SWIFT_VERSION'] = "3.0"
      end
    end
  end
end
