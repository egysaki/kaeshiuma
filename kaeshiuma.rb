require 'bundler/setup'
Bundler.require

#アネモネを使わない場合
uri = 'http://db.netkeiba.com/?pid=horse_top'
doc = Nokogiri::HTML(open(uri), nil, "EUC-JP")
horse_links = {}
doc.xpath("/html/body//div[@class='hitchart_block']//tbody/tr//a").each do |node|
  node = node.to_s.encode "UTF-8"
  link = node.slice(/\/horse\/\d*\//) 
  name = node.slice(/\>.*\</).gsub(/\<|\>/, "")
  horse_links[name] = link
end

horse_links.each do |name, link|
  uri = "http://db.netkeiba.com/#{link}"
  doc = Nokogiri::HTML(open(uri), nil, "EUC-JP")
  doc.xpath("/html/body//div[@id='contents']").each do |node|
    db_main_box = node.xpath("./div[@id='db_main_box']")

    #基本データ1
    horse_title = node.xpath(".//div[@class='horse_title']")
    name = horse_title.xpath("./h1").to_s.encode "UTF-8"
    name = name.slice(/\>.*\</).gsub(/\<|\>/, "")
    if name.include?("外")
      name = name.split(/外/)[1].split(/[[:blank:]]/)[0]
    elsif name.include?("地")
      name = name.split(/地/)[1].split(/[[:blank:]]/)[0]
    end
    name = name.split(/[[:blank:]]/)[0]
    status = horse_title.xpath("./p[@class='txt_01']").to_s.encode "UTF-8"
    status = status.slice(/\>.*\</).gsub(/\<|\>/, "").split(/[[:blank:]]/)
    active_status = status[0]
    sex = status[1][0]
    age = status[1].slice(/\d+/)
    hair_color = status[2]

    #基本データ2
    main_data = node.xpath(".//div[@class='db_main_deta']")
    profile = main_data.xpath(".//div[@class='db_prof_area_02']")
    birth_day = profile.xpath("./table//tr[1]/td").to_s.encode "UTF-8"
    birth_day = birth_day.slice(/\>.*\</).gsub(/\<|\>/, "")
    trainer = profile.xpath(".//tr[2]/td").to_s.encode "UTF-8"
    trainer = trainer.slice(/\>.*\</).gsub(/\<|\>/, "")
    trainer = trainer.split[0].split(/\//)[0] + trainer.split[1]
    owner = profile.xpath(".//tr[3]/td").to_s.encode "UTF-8"
    owner = owner.slice(/\>.*\</).gsub(/\<|\>/, "").split(/title=/)[1].split(/\"/)[1]
    producer = profile.xpath(".//tr[4]/td").to_s.encode "UTF-8"
    producer = producer.slice(/\>.*\</).gsub(/\<|\>/, "").split(/title=/)[1].split(/\"/)[1]

    #基本データ3
    blood_table = profile.xpath(".//table[@class='blood_table']")
    father = blood_table.xpath("./tr[1]/td[1]/a").to_s.encode "UTF-8"
    father = father.slice(/\>.*\</).split(/\</)[0].split(/\>/)[1]
    mother = blood_table.xpath("./tr[3]/td[1]/a").to_s.encode "UTF-8"
    mother = mother.slice(/\>.*\</).split(/\</)[0].split(/\>/)[1]
    g_father = blood_table.xpath("./tr[3]/td[2]/a").to_s.encode "UTF-8"
    g_father = g_father.slice(/\>.*\</).split(/\</)[0].split(/\>/)[1]

    list = name, active_status, sex, age, hair_color, birth_day, trainer, owner, producer, father, mother, g_father
    p list
  end
end


#opts = {
#  depth_limit: 0
#}
#
#horse_links = {}
#
#Anemone.crawl("http://db.netkeiba.com/?pid=horse_top", opts) do |anemone|
#  anemone.on_every_page do |page|
#    doc = Nokogiri::HTML.parse(page.body.encode("UTF-8", "EUC-JP"))
#    doc.xpath("//div[@class='hitchart_block']//tbody/tr//a").each do |node|
#      # 更に絞り込んでstring型に変換
#      link = node.to_s.slice(/\/horse\/\d*\//) 
#      name = node.to_s.slice(/\>.*\</).gsub(/\<|\>/, "")
#      horse_links[name] = link
#    end
#  end
#puts 555
#end
#puts 555
#puts horse_links


#options = {
#  :depth_limit => 1
#}
#Anemone.crawl('http://192.168.56.101:3000', options) do |anemone|
#  anemone.on_every_page do |page|
#    if page.doc
#      p page.url.to_s
#      p page.doc.at('title').inner_html
#    end
#  end
#end
#agent = Mechanize.new
#page = agent.get('http://192.168.56.101:3000')
