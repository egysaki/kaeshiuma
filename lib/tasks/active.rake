task active: :environment do
#def self.get_info(horse_name)
  #horse_name ="アーモンドアイ"
  horse_name ="レイデオロ"
  #horse_name ="レインボーライン"
  #horse_name ="フロンティア"
  agent = Mechanize.new

  uri = 'http://db.netkeiba.com/?pid=horse_search_detail'
  page = agent.get(uri)
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
 # origin_name = name
 # if name.include?("外")
 #   name = origin_name.split(/外/)[1].split(/[[:blank:]]/)[0]
 # elsif name.include?("地")
 #   name = origin_name.split(/地/)[1].split(/[[:blank:]]/)[0]
 # end
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
    #text = tr.inner_text.gsub(/(\n)+/, ' ').split(' ')#.reject(&:blank?)
    #text = tr.inner_text.gsub(/(\n)+/, ' ').split(' ').reject(&:blank?)
    #text.delete("**")

    event_date = tds[0]
    course_info = tds[1]
    weather = tds[2]
    race_round = tds[3]
    puts race_name = tds[4].inner_text
    # 映像
    horse_count = tds[6]
    break
    post_position = text[6]
    horse_number = text[7]
    odds = text[8]
    popularity = text[9]
    order_of_placing = text[10]
    jokey_name = text[11]
    basis_weight = text[12]
    distance_info = text[13]
    course_status = text[14]
    # 指数
    accomplishment_time = text[15]
    margin = text[16]
    if course_info.include?('新潟') && distance_info.include?('1000')
    # タイム指数
      passing_info = nil
      pace = text[17]
      time_for_3f = text[18]
      weight_info = text[19]
      # 厩舎コメント
      # 備考
      winner_horse = text[20]
      prize = text[21]
    else
    # タイム指数
      passing_info = text[17]
      pace = text[18]
      time_for_3f = text[19]
      weight_info = text[20]
      # 厩舎コメント
      # 備考
      winner_horse = text[21]
      prize = text[22]
    end

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
    race_results << [event_date,course,weather,race_round,race_name,grade,horse_count,post_position,horse_number,odds,popularity,order_of_placing,jokey_name,basis_weight,distance_info,course_status,accomplishment_time,margin,passing_info,pace,time_for_3f,weight_info,winner_horse,prize]
  #        course_type = distance_info.gsub(/\d+/, '')
  #        distance = distance_info.gsub(/芝|ダ/, '')
  #        race = Race.find_or_create_by(name: race_name, distance: distance.to_i, course_id: course.id, grade: grade, course_type: course_type)

  #        race_round = course_info.slice(/\d+$/)
  #        race_info = RaceInfo.find_or_create_by(race_id: race.id, course_status: course_status, event_date: event_date, race_round: race_round, weather: weather)

  #        jokey = Jokey.find_or_create_by(name: jokey_name)

  #        weight = weight_info.split(/\(/)[0].to_i
  #        weight_difference = weight_info.split(/\(/)[1].gsub(/\)/, '')
  #        horse_race_result = HorseRaceResult.find_or_create_by(horse_id: horse.id, race_info_id: race_info.id)
  #        horse_race_result.update!(accomplishment_time: accomplishment_time, time_for_3f: time_for_3f, order_of_placing: order_of_placing, passing_info: passing_info, weight: weight, basis_weight: basis_weight, popularity: popularity, post_position: post_position, horse_number: horse_number, margin: margin.to_i, odds: odds, weight_difference: weight_difference, pace: pace, jokey_id: jokey.id)
  #    end
    
  
  end
  p horse_info
  race_results.each do |result|
  p result
  end
#end
end
