task active: :environment do
  #horse_name ="アーモンドアイ"
  horse_name ="レイデオロ"
  #horse_name ="レインボーライン"
  #horse_name ="フロンティア"
  agent = Mechanize.new

  uri = 'http://db.netkeiba.com/?pid=horse_search_detail'
  page = agent.get(uri)
  sleep 1
  form = page.forms[1]
  form.word = horse_name
  form.checkbox_with(name: 'match').check
  form.under_age = 'none'
  form.over_age = 'none'
  form.sort = 'prize'
  form.list = 100
  search_result_page = agent.submit(form)

  if search_result_page.uri.to_s == 'http://db.netkeiba.com/'
    if search_result_page.at("table[@class='nk_tb_common race_table_01'] td").blank?
      puts "見つかりませんでした"
    else
      link = search_result_page.at("table[@class='nk_tb_common race_table_01'] td a")[:href]
      @info_uri = "http://db.netkeiba.com#{link}"
      puts @info_uri
    end
  elsif search_result_page.uri.to_s.include?('/horse/')
    @info_uri = search_result_page.uri.to_s
    puts @info_uri
  end

  page = agent.get(@info_uri)

  #基本情報

  node = page.search("div[@id='contents']")
  
  db_main_box = node.search("div[@id='db_main_box']")

  horse_title = node.search("div[@class='horse_title']")
  name = horse_title.inner_text.strip
  name = name.split(/[[:blank:]]/)[0]

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
    prize = profile.search("tr[8]/td").inner_text.gsub(/\n/, '')
    result = profile.search("tr[9]/td").inner_text
  else
    producer = profile.search("tr[4]/td").inner_text
    prize = profile.search("tr[7]/td").inner_text.gsub(/\n/, '')
    result = profile.search("tr[8]/td").inner_text
  end
  
  #基本データ3
  blood_table = node.search("table[@class='blood_table']")
  father = blood_table.search("tr[1]/td[1]/a").inner_text
  mother = blood_table.search("tr[3]/td[1]/a").inner_text
  g_father = blood_table.search("tr[3]/td[2]/a").inner_text

  #画像
  photo = node.search("//*[@id='HorseMainPhoto']").at('img')
  if photo
    src_path = node.search("//*[@id='HorseMainPhoto']").at('img')['src']
  else
    src_path = nil
  end

  horse_info = [name,active_status,sex,age,hair_color_type,birth_day,trainer,owner,producer,prize,result,father,mother,g_father,src_path]
  
  #レース情報
  node = page.search("table[@class='db_h_race_results nk_tb_common']")

  race_results = []
  count = 0
  trs = node.search("tbody tr")
  trs.each do |tr|
    count += 1
    tds = tr.search("td")
    
    event_date = tds[0].inner_text
    course_info = tds[1].inner_text
    weather = tds[2].inner_text
    race_round = tds[3].inner_text
    race_name = tds[4].inner_text
    # 映像
    horse_count = tds[6].inner_text
    post_position = tds[7].inner_text
    horse_number = tds[8].inner_text
    odds = tds[9].inner_text
    popularity = tds[10].inner_text
    order_of_placing = tds[11].inner_text
    jokey_name = tds[12].inner_text
    basis_weight = tds[13].inner_text
    distance_info = tds[14].inner_text
    course_status = tds[15].inner_text
    # 指数
    accomplishment_time = tds[17].inner_text
    margin = tds[18].inner_text
    # タイム指数
    passing_info = tds[20].inner_text
    pace = tds[21].inner_text
    time_for_3f = tds[22].inner_text
    if tds[22].to_s.include?('rank_1')
      f_rank = 1
    elsif tds[22].to_s.include?('rank_2')
      f_rank = 2
    elsif tds[22].to_s.include?('rank_3')
      f_rank = 3
    else
      f_rank = nil
    end
    weight_info = tds[23].inner_text
    # 厩舎コメント
    # 備考
    winner_horse = tds[26].inner_text
    prize = tds[27].inner_text

    #競馬場を取得
    unless course_info =~ /^\d+.*\d+$/
      course = course_info
    else
      course = course_info.gsub(/\d+/, '')
    end

    #レース名とグレードを取得
    if race_name =~ (/\(.*\)/)
      if race_name.include?('(春)')
        grade = 'G1'
        race_name = '天皇賞（春）'
      elsif race_name.include?('(秋)')
        grade = 'G1'
        race_name = '天皇賞（秋）'
      else
        grade = race_name.split(/\(/)[1].gsub(/\)/, '')
        race_name = race_name.split(/\(/)[0]
      end
    elsif race_name =~ (/新馬$/)
      grade = race_name + '戦'
    elsif race_name =~ (/新馬$/) || race_name =~ (/未勝利$/)
      grade = race_name + '戦'
    else
      grade = nil
    end
    race_results << [event_date,course,weather,race_round,race_name,grade,horse_count,post_position,horse_number,odds,popularity,order_of_placing,jokey_name,basis_weight,distance_info,course_status,accomplishment_time,margin,passing_info,pace,time_for_3f,weight_info,winner_horse,prize,f_rank]
  end
  p horse_info
  race_results.each do |result|
  p result
  end
end
