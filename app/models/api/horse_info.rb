module Api
  class HorseInfo

    def self.return_horse_info(horse, url, limit = 5)
      contents_body = []
      contents_body << {
        type: 'bubble',
        header: {
          type: 'box',
          layout: 'vertical',
          contents: [
            {
              type: 'text',
              text: "#{horse.name} #{horse.sex}#{horse.age}歳",
              size: 'xl',
              color: '#ffffff'
              weight: 'bold',
              wrap: true
            }
          ]
        },
        hero: {
          type: 'image',
          url: url + horse.src_path,
          size: 'full',
          aspectMode: 'cover'
        },
        body: {
          type: 'box',
          layout: 'vertical',
          flex: 1,
          contents: [
            {
              type: 'text',
              text: "父: #{horse.father.name}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "母: #{horse.mother.name}",
              size: 'lg',
              wrap: true
            },
            {
              type: 'text',
              text: "母父: #{horse.g_father.name}",
              size: 'lg',
              wrap: true
            }
          ]
        },
        styles: {
          header: {
            backgroudColor: '#006400'
          }
        }
      }

      horse.horse_race_results.joins(:race_info).order("race_infos.event_date desc").limit(limit).each do |result|
        contents_body << {
          type: 'bubble',
          header: {
            type: 'box',
            layout: 'vertical',
            contents: [
              {
                type: 'text',
                text: "#{result.race_info.race.name}(#{result.race_info.race.grade})",
                size: 'xl',
                weight: 'bold',
                wrap: true,
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
                    url: url + "/assets/order_of_placing/order_of_placing-#{result.order_of_placing}.jpg",
                    aspectRatio: '1:1',
                    margin: "lg",
                    size: 'lg',
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
                    text: "着 #{result.jokey.name}(#{result.basis_weight})",
                    size: 'lg',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'separator'
                  },
                  {
                    type: 'text',
                    text: "#{result.race_info.event_date.strftime('%Y/%m/%d')} #{result.race_info.race.course.name}#{result.race_info.race_round}R",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'separator'
                  },
                  {
                    type: 'text',
                    text: "#{result.race_info.race.course_type}#{result.race_info.race.distance}m #{result.accomplishment_time} #{result.race_info.course_status}",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'separator'
                  },
                  {
                    type: 'text',
                    text: "#{result.post_position}枠#{result.horse_number}番#{result.popularity}人 #{result.odds}倍",
                    size: 'md',
                    weight: 'bold',
                    wrap: true
                  },
                  {
                    type: 'separator'
                  },
                  {
                    type: 'text',
                    text: "#{result.passing_info}(#{result.time_for_3f}) #{result.weight}(#{result.weight_difference})",
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
              backgroudColor: grade_color(result.race_info.race.grade)
            }
          }
        }
      end

      contents = {
        type: 'carousel',
        contents: contents_body
      }
    end

  end

  private

  def grade_color(grade)
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
