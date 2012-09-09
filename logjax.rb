#!/usr/bin/env ruby

require 'sinatra'
require 'cgi'
require 'haml'
require 'coffee-script'
require 'execjs'

class Logjax < Sinatra::Application

  configure do
    set :logpath, 'log.log'
  end

  get '/' do
    @@log = File.open(settings.logpath).readlines.map { |line| CGI.escapeHTML(line.force_encoding("ISO-8859-1").encode('UTF-8', replace: nil)).downcase }
    haml :index
  end

  get '/application.js' do
    coffee :application
  end

  get '/match/:pattern' do
    content_type 'text/plain'
    begin
      @@log.grep(/#{CGI.unescape(params[:pattern])}/).last(30).join('<br/>')
    rescue RegexpError, ArgumentError => ex
      "Regex Fail"
    end
  end

end
