Pod::Spec.new do |s|
  s.name         = "MaterialMotionTransitions"
  s.summary      = "Material Motion Transitions for Apple Devices"
  s.version      = "1.1.0"
  s.authors      = "The Material Motion Authors"
  s.license      = "Apache 2.0"
  s.homepage     = "https://github.com/material-motion/transitions-objc"
  s.source       = { :git => "https://github.com/material-motion/transitions-objc.git", :tag => "v" + s.version.to_s }
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.default_subspec = "lib"

  s.subspec "lib" do |ss|
    ss.public_header_files = "src/*.h"
    ss.source_files = "src/*.{h,m,mm}", "src/private/*.{h,m,mm}"
  end

  s.subspec "examples" do |ss|
    ss.source_files = "examples/*.{swift}", "examples/supplemental/*.{swift}"
    ss.exclude_files = "examples/TableOfContents.swift"
    ss.resources = "examples/supplemental/*.{xcassets}"
    ss.dependency "MaterialMotionTransitions/lib"

    ss.dependency "MaterialMotionCoreAnimation"
    ss.dependency "MaterialMotionPop"
    ss.dependency "MaterialMotionDirectManipulation"
  end

  s.subspec "tests" do |ss|
    ss.source_files = "tests/src/*.{swift}", "tests/src/private/*.{swift}"
    ss.dependency "MaterialMotionTransitions/lib"
    ss.dependency "MaterialMotionRuntime/tests"
  end

  s.dependency "MaterialMotionRuntime", "~> 6.0"
end
