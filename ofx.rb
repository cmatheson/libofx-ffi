#!/usr/bin/ruby1.9.1

require 'ffi'
require 'ofx'

require 'ap'
ap OFX.parse "secret.ofx"
