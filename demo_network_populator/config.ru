require 'rubygems'
require 'sinatra'


configure :production do
	log = File.new('logs/sinatra.log','a')
	$stdout.reopen(log)
	$stderr.reopen(log)
end

require File.expand_path('../app.rb', __FILE__)

run Sinatra::Application