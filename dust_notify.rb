require 'net/http'
require 'dotenv'
Dotenv.load

class DustNotify
  URL = 'https://notify-api.line.me/api/notify'.freeze
  PACKAGE_ID = 11537
  STICKER_ID = 52002750

  def initialize(message)
    @message = message
  end

  def send
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
      https.request(request)
    end
  end

  private

  def request
    request = Net::HTTP::Post.new(uri.path)
    request['Authorization'] = "Bearer #{ENV['TOKEN']}"
    request.set_form_data(message: @message, stickerPackageId: 11537, stickerId: 52002750)
    request
  end

  def uri
    URI.parse(URL)
  end
end

dust_notifiy = DustNotify.new('ゴミの日です')
dust_notifiy.send
