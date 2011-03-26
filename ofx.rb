#!/usr/bin/ruby1.9.1

require 'ofx'

require 'ap'
ap OFX.parse "secret.ofx"
