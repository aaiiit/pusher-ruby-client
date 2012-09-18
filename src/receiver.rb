require 'rubygems'
require 'pusher'
require '../config/config'
require 'sinatra'
require 'json'

post '/webhooks' do
  webhook = Pusher::WebHook.new(request)
  if webhook.valid?
    webhook.events.each do |event|
      case event["name"]
      when 'channel_occupied'
        puts "Channel occupied: #{event["channel"]}"
      when 'channel_vacated'
        puts "Channel vacated: #{event["channel"]}"
      end
    end
  else
    status 401
  end
  return
end

post '/hello_world' do
    content_type 'aplication/json'
    puts "#{params.inspect}"
    #Pusher['test01'].trigger('the_receiver', {:message => 'You said "' + params[:message] + '"'})
end

get '/pusher/auth' do
    puts "Params "
    auth = Pusher[params[:channel_name]].authenticate(params[:socket_id])
    puts "Authenticated"
    puts auth.to_json
    puts "#{params[:callback]} (#{auth.to_json})"
    return "#{params[:callback]} (#{auth.to_json})"
end