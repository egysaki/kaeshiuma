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
  doc.xpath("/html/body//div[@id='contents']/div[@id='db_main_box']//div[@class='horse_title']").each do |node|
    name = node.xpath("./h1").to_s.encode "UTF-8"
    name = name.slice(/\>.*\</).gsub(/\<|\>/, "")
    if name.include?("外")
      name = name.split(/外/)[1].split(/[[:blank:]]/)[0]
    elsif name.include?("地")
      name = name.split(/地/)[1].split(/[[:blank:]]/)[0]
    end
    name = name.split(/[[:blank:]]/)[0]
    status = node.xpath("./p[@class='txt_01']").to_s.encode "UTF-8"
    status = status.slice(/\>.*\</).gsub(/\<|\>/, "").split(/[[:blank:]]/)
    active_status = status[0]
    sex = status[1][0]
    age = status[1].slice(/\d+/)
    hair_color = status[2]
    list = name, active_status, sex, age, hair_color
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
