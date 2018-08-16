module Api
  class ActiveHorseInfo

    def self.return_horse_info(horse_name, url, limit = 5)

      self.get_info(horse_name, limit)
      if @undefined
        return false
      end

      contents_body = []
      contents_body << {
        type: 'bubble',
        header: {
          type: 'box',
          layout: 'vertical',
          contents: [
            {
              type: 'text',
              text: @horse_info[0],
              size: 'xl',
              color: '#ffffff',
              weight: 'bold'
            }
          ]
        },
        body: {
          type: 'box',
          layout: 'vertical',
          flex: 1,
          contents: [
            {
              type: 'text',
              text: "#{@horse_info[2]}#{@horse_info[3]}歳 #{@horse_info[4]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "生年月日: #{@horse_info[5]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "調教師: #{@horse_info[6]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "馬主: #{@horse_info[7]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "生産者: #{@horse_info[8]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "獲得賞金: #{@horse_info[9]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "通算成績: #{@horse_info[10]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "父: #{@horse_info[11]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "母: #{@horse_info[12]}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "母父: #{@horse_info[13]}",
              size: 'lg',
              wrap: true
            }
          ]
        },
        styles: {
          header: {
            backgroundColor: '#006400'
          }
        }
      }

      @race_results.each do |result|
        contents_body << {
          type: 'bubble',
          header: {
            type: 'box',
            layout: 'vertical',
            contents: [
              {
                type: 'text',
                text: "#{result[4]}(#{result[5]})",
                size: 'xl',
                weight: 'bold',
                color: '#ffffff'
              }
            ]
          },
          body: {
            type: 'box',
            layout: 'horizontal',
            spacing: 'md',
            contents: [
              {
                type: 'box',
                layout: 'vertical',
                flex: 1,
                contents: [
                  {
                    type: 'image',
                    url: url + "/assets/order_of_placing/order_of_placing-" + result[11] + ".jpg",
                    aspectRatio: '1:1',
                    margin: "lg",
                    size: 'lg'
                  }
                ]
              },
              {
                type: 'box',
                layout: 'vertical',
                flex: 5,
                contents: [
                  {
                    type: 'text',
                    text: "着 #{result[12]}(#{result[13]})",
                    size: 'lg',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'text',
                    text: "#{result[0]} #{result[1]}#{result[3]}R",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'text',
                    text: "#{result[14]}m #{result[16]} #{result[15]}",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'text',
                    text: "#{result[7]}枠#{result[8]}番#{result[10]}人 #{result[9]}倍",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'text',
                    text: "#{result[18]}(#{result[20]})",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'text',
                    text: "馬体重: #{result[21]}",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'text',
                    text: "勝ち馬: #{result[22]}",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  }
                  {
                    type: 'text',
                    text: "着差: #{result[17]}",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  }
                ]
              }
            ]
          },
          styles: {
            header: {
              backgroundColor: self.grade_color(result[5])
            }
          }
        }
      end

      contents = {
        type: 'carousel',
        contents: contents_body
      }
    end

    def self.order_place_img(url, result)
      url + "/assets/order_of_placing/order_of_placing-#{result}.jpg"
    end

    def self.grade_color(grade)
      case grade
      when 'G1'
        '#000066'
      when 'G2'
        '#cc0000'
      when 'G3'
        '#008000'
      else
        '#696969'
      end
    end

    def self.get_info(horse_name, limit)
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
          @undefined = true
          return
        else
          link = search_result_page.at("table[@class='nk_tb_common race_table_01'] td a")[:href]
          @info_uri = "http://db.netkeiba.com#{link}"
        end
      elsif search_result_page.uri.to_s.include?('/horse/')
        @info_uri = search_result_page.uri.to_s
      end
      page = agent.get(@info_uri)
    
      #基本情報
      @horse_info = []
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
    
      @horse_info = [name,active_status,sex,age,hair_color_type,birth_day,trainer,owner,producer,prize,result,father,mother,g_father,src_path]
      
      #レース情報
      node = page.search("table[@class='db_h_race_results nk_tb_common']")
    
      @race_results = []
      trs = node.search("tbody tr")
      count = 0
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
        @race_results << [event_date,course,weather,race_round,race_name,grade,horse_count,post_position,horse_number,odds,popularity,order_of_placing,jokey_name,basis_weight,distance_info,course_status,accomplishment_time,margin,passing_info,pace,time_for_3f,weight_info,winner_horse,prize]
        if count >= limit.to_i
          break
        end
      end
    end

    def self.grade_color(grade)
      case grade
      when 'G1'
        '#000066'
      when 'G2'
        '#cc0000'
      when 'G3'
        '#008000'
      else
        '#696969'
      end
    end

  end
end
