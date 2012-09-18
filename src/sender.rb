require 'rubygems'
require 'pusher'
require 'eventmachine'
require 'em-http-request'
require '../config/config'


 # Pusher['test01'].trigger!('new_message', {:some => 'Hello World!'})

 EM.run {

  deferrable = Pusher['private-test01'].trigger_async('my_event', 'hello world')

  deferrable.callback { # called on success
    puts "Message sent successfully."
    #EM.stop
  }
  deferrable.errback { |error| # called on error
    puts "Message could not be sent."
    puts error
    EM.stop
  }


}

