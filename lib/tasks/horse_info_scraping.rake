task horse_info_scraping: :environment do
  agent = Mechanize.new
  
  uri = 'http://db.netkeiba.com/?pid=horse_search_detail'
  page = agent.get(uri)
  form = page.forms[1]
  form.under_age = 3
  form.over_age = 3
  form.sort = 'prize'
  form.list = 100
  search_result_page = agent.submit(form)
  
  horse_links = {}
  
  total = search_result_page.search("div[@class='pager']").text
  total = total.split(/中/)[0].strip.chop.gsub(/\,/, '').to_i
  
  count = 0
  while 10 >= count do
  
    table = search_result_page.search("table[@class='nk_tb_common race_table_01'] td").each do |node|
      node.search("a").each do |a|
        if a[:href] =~ (/\/horse\/\d+/)
          name = a[:title]
          link = a[:href]
          horse_links[name] = link
        end
      end
    end
    count += 100
  
    next_page_link = search_result_page.link_with(:text => /次/).text
  
    unless next_page_link.nil?
      next_page = search_result_page.form_with(:name => 'sort')
      next_page.field_with(:name => 'page').value = (count + 100) / 100
      search_result_page = agent.submit(next_page)
    end
  
    sleep 1
    
  end

  puts " ==競走馬の情報を登録します== "
  horse_links.each do |name, link|
    uri = "http://db.netkeiba.com/#{link}"
    page = agent.get(uri)
    node = page.search("div[@id='contents']")
  
    db_main_box = node.search("div[@id='db_main_box']")
  
    horse_title = node.search("div[@class='horse_title']")
    name = horse_title.inner_text.strip
    origin_name = name
    if name.include?("外")
      name = origin_name.split(/外/)[1].split(/[[:blank:]]/)[0]
    elsif name.include?("地")
      name = origin_name.split(/地/)[1].split(/[[:blank:]]/)[0]
    end
    name = name.split(/[[:blank:]]/)[0]

    horse = Horse.find_or_initialize_by(name: name)

    status = horse_title.search("p[@class='txt_01']").inner_text.split(/[[:blank:]]/)
    active_status = status[0]
    sex = status[1][0]
    age = status[1].slice(/\d+/)
    hair_color_type = status[2]
  
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
  
    p list = name, active_status, sex, age, hair_color_type, birth_day, trainer, owner, producer, father, mother, g_father
  
    horse.active_status = active_status
    horse.sex = sex
    horse.age = age
    horse.hair_color_type = hair_color_type
    horse.birth_day = birth_day
    
    horse.save!
    puts "==#{horse.name}を登録しました=="

    sleep 1
  end
end
