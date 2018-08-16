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
                    url: self.order_place_img(url, result[11]),
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
                    text: "#{result[18]}(#{result[20]}) #{result[21]})",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'text',
                    text: "勝ち馬: #{result[22]} 着差: #{result[17]})",
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
    
      @horse_info = [name,active_status,sex,age,hair_color_type,birth_day,trainer,owner,producer,prize,result,father,mother,g_father]
      
      #レース情報
      node = page.search("table[@class='db_h_race_results nk_tb_common']")
    
      @race_results = []
      trs = node.search("tbody tr")
      count = 0
      trs.each do |tr|
        count += 1
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
        @race_results << [event_date,course,weather,race_round,race_name,grade,horse_count,post_position,horse_number,odds,popularity,order_of_placing,jokey_name,basis_weight,distance_info,course_status,accomplishment_time,margin,passing_info,pace,time_for_3f,weight_info,winner_horse,prize]
        if count >= limit.to_i
          break
        end
      end
    end

    def self.order_place_img(url, result)
      url + "/assets/order_of_placing/order_of_placing-#{result.order_of_placing}.jpg"
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
