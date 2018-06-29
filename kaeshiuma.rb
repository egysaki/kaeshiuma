require 'bundler/setup'
Bundler.require

agent = Mechanize.new

uri = 'http://db.netkeiba.com/?pid=horse_top'
horse_links = {}
page = agent.get(uri)
page.search("div[@class='hitchart_block'] tbody tr a").each do |node|
  link = node[:href]
  name = node.inner_text
  horse_links[name] = link
end

horse_links.each do |name, link|
  uri = "http://db.netkeiba.com/#{link}"
  page = agent.get(uri)
  node = page.search("div[@id='contents']")

  db_main_box = node.search("div[@id='db_main_box']")

  #基本データ1
  horse_title = node.search("div[@class='horse_title']")
  name = horse_title.inner_text.strip
  origin_name = name
  if name.include?("外")
    name = origin_name.split(/外/)[1].split(/[[:blank:]]/)[0]
  elsif name.include?("地")
    name = origin_name.split(/地/)[1].split(/[[:blank:]]/)[0]
  end
  name = name.split(/[[:blank:]]/)[0]
  status = horse_title.search("p[@class='txt_01']").inner_text.split(/[[:blank:]]/)
  active_status = status[0]
  sex = status[1][0]
  age = status[1].slice(/\d+/)
  hair_color = status[2]

  #基本データ2
  main_data = node.search("div[@class='db_main_deta']/table")
  profile = node.search("table[@summary='のプロフィール']")
  birth_day = profile.search("tr[1]/td").inner_text
  trainer = profile.search("tr[2]/td").inner_text
  owner = profile.search("tr[3]/td").inner_text
  if profile.search("tr[4]/th").inner_text.include?('募集情報')
    producer = profile.search("tr[5]/td").inner_text
  else
    producer = profile.search("tr[4]/td").inner_text
  end

  #基本データ3
  blood_table = node.search("table[@class='blood_table']")
  father = blood_table.search("tr[1]/td[1]/a").inner_text
  mother = blood_table.search("tr[3]/td[1]/a").inner_text
  g_father = blood_table.search("tr[3]/td[2]/a").inner_text

  list = name, active_status, sex, age, hair_color, birth_day, trainer, owner, producer, father, mother, g_father
  p list

  sleep 1
end
