abstract_target 'MaterialMotionTransitions' do
	pod 'MaterialMotionTransitions', :path => './'

  # For release
  #pod 'MaterialMotionRuntime'

  # For on-going development
  pod 'MaterialMotionRuntime' , :git => 'git@github.com:material-motion/material-motion-runtime-objc.git', :branch => 'develop'

  # If you need to make changes to the runtime
  #pod 'MaterialMotionRuntime' , :git => '/path/to/runtime-objc', :branch => 'develop'

  workspace 'MaterialMotionTransitions.xcworkspace'
	use_frameworks!

	target "UnitTests" do
		project 'tests/apps/UnitTests/UnitTests.xcodeproj'
	end
end
