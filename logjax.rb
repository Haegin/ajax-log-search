#!/usr/bin/env ruby

require 'sinatra'
require 'cgi'
require 'haml'
require 'coffee-script'
require 'execjs'

configure do
  logpath = 'log.log'
  set :log, File.open(logpath).readlines.map { |line| CGI.escapeHTML(line.force_encoding("ISO-8859-1").encode('UTF-8', replace: nil)).downcase }
end

get '/' do
  haml :index
end

get '/application.js' do
  coffee :application
end

get '/match/:pattern' do
  content_type 'text/plain'
  begin
    settings.log.grep(/#{CGI.unescape(params[:pattern])}/).take(40).join('<br/>')
  rescue RegexpError, ArgumentError => ex
    "Regex Fail"
  end
end

__END__
