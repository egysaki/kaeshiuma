task get_horse_image: :environment do
  agent = Mechanize.new

  Rails.logger.info "馬の画像の取得を開始します。"
  
  horses = Horse.where.not(link: nil)
  horses.each do |horse|
    begin
      puts horse.name
      uri = "http://db.netkeiba.com/#{horse.link}"
      page = agent.get(uri)
      node = page.search("div[@id='contents']")

      photo = node.search("//*[@id='HorseMainPhoto']").at('img')
      if photo
        src = node.search("//*[@id='HorseMainPhoto']").at('img')['src']
        src_path = "/assets/images/horse/horse-#{horse.id}.jpg"
      p  agent.get(src).save_as("./app" + src_path)
      end
      horse.src_path = src_path
      horse.save!

      puts "#{horse.name}の画像を保存しました。"
    rescue => e
      puts e
    end

    sleep 1
  end

  system "rm ./app/assets/images/horse/horse*.jpg.*"
end
