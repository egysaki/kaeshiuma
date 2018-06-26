require 'bundler/setup'
Bundler.require

opts = {
  depth_limit: 0
}

# AnemoneにクロールさせたいURLと設定を指定した上でクローラーを起動！
Anemone.crawl("http://www.nicovideo.jp/ranking", opts) do |anemone|
  # 指定したページのあらゆる情報(urlやhtmlなど)をゲットします。
  anemone.on_every_page do |page|
    i = 1 # 後で使います。
    # page.docでnokogiriインスタンスを取得し、xpathで欲しい要素(ノード)を絞り込む
    page.doc.xpath("/html/body//section[@class='content']/div[contains(@class,'contentBody')]//li[contains(@class,'videoRanking')]/div[@class='itemContent']").each do |node|
      # 更に絞り込んでstring型に変換
      title = node.xpath("./p/a/text()").to_s
      # 更に絞り込んでstring型に変換      
      viewCount = node.xpath("./div[@class='itemData']//li[contains(@class,'view')]/span/text()").to_s 
      # 表示形式に整形
      puts i.to_s + "位：再生数：" + viewCount + " | " + title
      puts "\n———————————————–\n"
      i += 1 # iは順位を示しています。あるランキングを上から順番に取り出しています。
    end # node終わり
  end # page終わり
end # Anemone終わり


options = {
  :depth_limit => 1
}
Anemone.crawl('http://192.168.56.101:3000', options) do |anemone|
  anemone.on_every_page do |page|
    if page.doc
      p page.url.to_s
      p page.doc.at('title').inner_html
    end
  end
end
agent = Mechanize.new
page = agent.get('http://192.168.56.101:3000')
