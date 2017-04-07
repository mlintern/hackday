# encoding: utf-8
# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require 'json'
require 'active_support/core_ext/hash/conversions'
require 'time'
require 'compendium-api'
require 'nretnil-fake-data'
require 'nretnil-password'

configure do
  enable :reloader # , :sessions
  # set :session_secret, "T1syUdT5jFayI8L77OMTRrSFS"
  set :public_folder, 'public'
  set :port, '8888'
  set :views, 'views'
  set :bind, '0.0.0.0'
end

require './env' if File.exist?('env.rb')
require './lib/data'
require './lib/helpers'
require './lib/routes'
