Pod::Spec.new do |s|
  s.name         = "MaterialMotionTransitions"
  s.summary      = "Material Motion Transitions for Apple Devices"
  s.version      = "1.1.0"
  s.authors      = "The Material Motion Authors"
  s.license      = "Apache 2.0"
  s.homepage     = "https://github.com/material-motion/material-motion-transitions-objc"
  s.source       = { :git => "https://github.com/material-motion/material-motion-transitions-objc.git", :tag => "v" + s.version.to_s }
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.public_header_files = "src/*.h"
  s.source_files = "src/*.{h,m,mm}", "src/private/*.{h,m,mm}"
  s.header_mappings_dir = "src"

  s.dependency "MaterialMotionRuntime", "~> 6.0"
end
