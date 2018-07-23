class WebhookController < ApplicationController

  def callback
    client = Line::Bot::Client.new { |config|
      config.channel_secret = CHANNEL_SECRET
      config.channel_token = CHANNEL_ACCESS_TOKEN
    }

    body = request.body.read
    events = client.parse_events_from(body)

    events.each { |event|
      case event 
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    }
    "OK"
  end

  #Lineからのcallbackか認証
  #protect_from_forgery with: :null_session

 # CHANNEL_SECRET = '066a0e3810610a05f319b2a4b9537d7f'
 # #OUTBOUND_PROXY = 'http://fixie:VIyppzCnwQLL4wF@velodrome.usefixie.com:80'
 # #CHANNEL_ACCESS_TOKEN = 'cAGZX+n1ST0Bcz0SJ3LCXjDIgoOaM73lG5kdEE9k8ZIU2ZOtsmAKm8BEiHiFPo2KWosC8tkSvzSv2VvJ3UZJ0R9tTI1wkf0l66WFiEYF78Kb7/aX5+VP9sV8RGz0MP7WVG3YJhxjMk9jJ/8F7Vm2/wdB04t89/1O/w1cDnyilFU='

 # def callback
 #   unless is_validate_signature
 #     render :nothing => true, status: 470
 #   end

 #   event = params["events"][0]
 #   event_type = event["type"]
 #   reply_token = event["replyToken"]

 #   case event_type
 #   when "message"
 #     input_text = event["message"]["text"]
 #     output_text = input_text
 #   end

 #   #client = LineClient.new(CHANNEL_ACCESS_TOKEN, OUTBOUND_PROXY)
 #   client = LineClient.new
 #   res = client.reply(reply_token, output_text)

 #   if res.status == 200
 #     logger.info({success: res})
 #   else
 #     logger.info({fail: res})
 #   end

 #   render :nothing => true, status: :ok
 # end

 # private
 # # verify access from LINE
 # def is_validate_signature
 #   signature = request.headers["X-LINE-Signature"]
 #   http_request_body = request.raw_post
 #   hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, CHANNEL_SECRET, http_request_body)
 #   signature_answer = Base64.strict_encode64(hash)
 #   signature == signature_answer
 # end
end
