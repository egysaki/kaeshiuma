task horse_race_info_scraping: :environment do
  agent = Mechanize.new

  Rails.logger.info "スクレイピングを開始します。"
  
  horses = Horse.where(age: 3)
  horses.each do |horse|
      uri = "http://db.netkeiba.com/#{horse.link}"
      page = agent.get(uri)
      node = page.search("table[@class='db_h_race_results nk_tb_common']")

      trs = node.search("tbody tr")
      trs.each do |tr|
        begin
          text = tr.inner_text.gsub(/(\n)+/, ' ').split(' ').reject(&:blank?)
          text.delete("**")

          event_date = text[0]
          course_info = text[1]
          weather = text[2]
          race_round = text[3]
          race_name = text[4]
          # 映像
          horse_count = text[5]
          post_position = text[6]
          horse_number = text[7]
          odds = text[8]
          popularity = text[9]
          order_of_placing = text[10]
          jokey_name = text[11]
          basis_weight = text[12]
          distance = text[13]
          course_status = text[14]
          # 指数
          accomplishment_time = text[15]
          margin = text[16]
          # タイム指数
          passing_info = text[17]
          pace = text[18]
          time_for_3f = text[19]
          weight_info = text[20]
          # 厩舎コメント
          # 備考
          winner_horse = text[21]
          prize = text[22]

          course = Course.find_by(name: course_info.gsub(/\d+/, ''))
          if race_name =~ (/\(.*\)/)
            grade = race_name.split(/\(/)[1].gsub(/\)/, '')
            race_name = race_name.split(/\(/)[0]
          elsif race_name =~ (/新馬$/) || race_name =~ (/未勝利$/)
            grade = race_name
          else
            grade = nil
          end
          race = Race.find_or_create_by(name: race_name, distance: distance, course_id: course.id, grade: grade)

          race_round = course_info.slice(/\d+$/)
          race_result = RaceResult.find_or_create_by(race_id: race.id, course_status: course_status, event_date: event_date, race_round: race_round, weather: weather)

          weight = weight_info.split(/\(/)[0].to_i
          weight_difference = weight_info.split(/\(/)[1].gsub(/\)/, '')
          horse_race_info = HorseRaceInfo.find_or_create_by(horse_id: horse.id, race_result_id: race_result.id, accomplishment_time: accomplishment_time, time_for_3f: time_for_3f, order_of_placing: order_of_placing, passing_info: passing_info, weight: weight, basis_weight: basis_weight, popularity: popularity, post_position: post_position, horse_number: horse_number, margin: margin, odds: odds, weight_difference: weight_difference, pace: pace)
        rescue => e
          Rails.logger.info e
          p e
          next
        end
      end
      break
    
    sleep 1
  end
end
