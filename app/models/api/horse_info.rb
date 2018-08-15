module Api
  class HorseInfo

    def self.return_horse_info(horse, limit = 5)
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
              weight: 'bold',
              wrap: true
            }
          ]
        },
        body: {
          type: 'box',
          layout: 'vertical',
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
            },
            {
              type: 'text',
              text: "http://db.netkeiba.com#{horse.link}",
              size: 'lg',
              weight: 'bold',
              wrap: true
            }
          ]
        }
      }

      horse.horse_race_results.limit(limit).each do |result|
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
                wrap: true
              }
            ]
          },
          body: {
            type: 'box',
            layout: 'vertical',
            contents: [
              {
                type: 'text',
                text: "#{result.order_of_placing}着 #{result.jokey.name}(#{result.basis_weight})",
                size: 'md',
                weight: 'bold',
                wrap: true
              },
              {
                type: 'text',
                text: "#{result.rece_info.event_date.strftime('%Y/%m/%d')} #{result.race_info.race.course.name}#{result.race_info.race_round}R",
                size: 'sm',
                weight: 'bold',
                wrap: true
              },
              {
                type: 'text',
                text: "#{result.race_info.race.course_type}#{result.race_info.distance}m #{result.accomplishment_time} #{result.race_info.course_status}",
                size: 'sm',
                weight: 'bold',
                wrap: true
              },
              {
                type: 'text',
                text: "#{result.post_position}枠#{result.horse_number}番#{result.popularity}人 #{horse.odds}倍",
                size: 'sm',
                weight: 'bold',
                wrap: true
              },
              {
                type: 'text',
                text: "#{result.passing_info}(#{result.time_for_3f}) #{result.weight}(#{result.weight_difference})",
                size: 'sm',
                weight: 'bold',
                wrap: true
              }
            ]
          }
        }
      end

      contents = {
        type: 'carousel',
        contents: contents_body
      }
    end

  end
end
