class LineClient
 # END_POINT = "https://api.line.me"

 # def post(path, data)
 #   client = Faraday.new(:url => END_POINT) do |conn|
 #     conn.request :json
 #     conn.response :json, :content_type => /\bjson$/
 #     conn.adapter Faraday.default_adapter
 #     conn.proxy @proxy
 #   end

 #   res = client.post do |request|
 #     request.url path
 #     request.headers = {
 #       'Content-type' => 'application/json',
 #       'Authorization' => "Bearer #{@channel_access_token}"
 #     }
 #     request.body = data
 #   end
 #   res
 # end

 # def reply(replyToken, text)

 #   messages = [
 #     {
 #       "type" => "text" ,
 #       "text" => text
 #     }
 #   ]

 #   body = {
 #     "replyToken" => replyToken ,
 #     "messages" => messages
 #   }
 #   post('/v2/bot/message/reply', body.to_json)
 # end

  
  CHANNEL_SECRET = '066a0e3810610a05f319b2a4b9537d7f'
  #OUTBOUND_PROXY = 'http://fixie:VIyppzCnwQLL4wF@velodrome.usefixie.com:80'
  CHANNEL_ACCESS_TOKEN = 'cAGZX+n1ST0Bcz0SJ3LCXjDIgoOaM73lG5kdEE9k8ZIU2ZOtsmAKm8BEiHiFPo2KWosC8tkSvzSv2VvJ3UZJ0R9tTI1wkf0l66WFiEYF78Kb7/aX5+VP9sV8RGz0MP7WVG3YJhxjMk9jJ/8F7Vm2/wdB04t89/1O/w1cDnyilFU='

  attr_reader :client

  def initialize
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = CHANNEL_SECRET
      condfig.channel_token = CHANNEL_ACCESS_TOKEN
    }
  end

  def reply(reply_tooken, text)
    client.reply_message(reply_token, text_message(message))
  end

  private

  def text_message(text)
    {
      "type" => "text" ,
      "text" => text
    }
  end

end
