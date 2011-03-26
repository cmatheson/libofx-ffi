Gem::Specification.new do |s|
  s.name          = "libofx-ffi"
  s.version       = "0.1.3"
  s.author        = "Cameron Matheson"
  s.email         = "cameron.matheson@gmail.com"
  s.homepage      = "http://github.com/cmatheson/libofx-ffi"
  s.description   = "Ruby/FFI wrapper for libofx"
  s.summary       = "libofx-ffi parses financial documents supported by libofx"

  s.platform      = Gem::Platform::RUBY
  s.has_rdoc      = false

  s.add_dependency "ffi", "~> 1.0.6"

  s.require_path = "lib"
  s.files = Dir.glob("lib/**/*") + Dir.glob("test/**/*")
end
