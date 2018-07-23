class WebhookController < ApplicationController
  protect_from_forgery except: :callback

  CHANNEL_SECRET = '066a0e3810610a05f319b2a4b9537d7f'
  CHANNEL_ACCESS_TOKEN = 'cAGZX+n1ST0Bcz0SJ3LCXjDIgoOaM73lG5kdEE9k8ZIU2ZOtsmAKm8BEiHiFPo2KWosC8tkSvzSv2VvJ3UZJ0R9tTI1wkf0l66WFiEYF78Kb7/aX5+VP9sV8RGz0MP7WVG3YJhxjMk9jJ/8F7Vm2/wdB04t89/1O/w1cDnyilFU='

  def callback
    unless is_validate_signature
      head 470
    end

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

          #url = root_url(only_path: false)
          case event.message['text']
          when '東京芝2000'
          message = {
            type: 'image',
            originalContentUrl: '/assets/course/tokyo-turf-2000.png',
            previewImageUrl: '/assets/course/tokyo-turf-2000.png'
          }
          end
          client.reply_message(event['replyToken'], message)
        end
      end
    }
    head :ok
  end

  private

  # verify access from LINE
  def is_validate_signature
    signature = request.headers["X-LINE-Signature"]
    http_request_body = request.raw_post
    hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, CHANNEL_SECRET, http_request_body)
    signature_answer = Base64.strict_encode64(hash)
    signature == signature_answer
  end

end
