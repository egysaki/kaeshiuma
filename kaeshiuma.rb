require 'bundler/setup'
Bundler.require

opts = {
  depth_limit: 0
}

html = (open('http://db.netkeiba.com/?pid=horse_top', "r:cp932").read.force_encoding('utf-8'))
doc = Nokogiri::HTML.parse(html)
doc.xpath("/html/body//div[@class='hitchart_block']//tbody/tr//a").each do |node|
  title = node.to_s
  puts title
end
#doc = Nokogiri::HTML(open('http://db.netkeiba.com/?pid=horse_top'), nil, 'CP932')
#puts doc
#puts 555
#puts doc.css("/html//di")
#puts doc.xpath("//div[@class='hitchart_block']")
#puts 555
#doc.xpath("/html/body//div[@class='hitchart_block']").each do |node|
#puts node
#  title = node.xpath("./td/a/").to_s
#  puts title
#end

# AnemoneにクロールさせたいURLと設定を指定した上でクローラーを起動！
Anemone.crawl("http://db.netkeiba.com/?pid=horse_top", opts) do |anemone|
  # 指定したページのあらゆる情報(urlやhtmlなど)をゲットします。
  anemone.on_every_page do |page|
    #puts page.url
    #i = 1 # 後で使います。
    # page.docでnokogiriインスタンスを取得し、xpathで欲しい要素(ノード)を絞り込む
    #page.doc.xpath("/html/body//section[@class='content']/div[contains(@class,'contentBody')]//li[contains(@class,'videoRanking')]/div[@class='itemContent']").each do |node|
    #page.doc.xpath("/html/body//div[@class='hitchart_block']/table[@class='db_table']/tbody/tr").each do |node|
    page.doc.xpath("/html/body//div[@class='hitchart_block']").each do |node|
      puts 555
      # 更に絞り込んでstring型に変換
      title = node.xpath("./td/a/").to_s
      # 更に絞り込んでstring型に変換      
      #viewCount = node.xpath("./div[@class='itemData']//li[contains(@class,'view')]/span/text()").to_s 
      # 表示形式に整形
      puts title
      #puts i.to_s + "位：再生数：" + viewCount + " | " + title
      #puts "\n———————————————–\n"
      #i += 1 # iは順位を示しています。あるランキングを上から順番に取り出しています。
    end # node終わり
  end # page終わり
end # Anemone終わり


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
