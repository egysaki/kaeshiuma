module Api
  class CourseInfo

    def self.return_course_info(course, url)
      if course =~ /^東京芝$/
       # contents = {
       #   type: 'carousel',
       #   contents: [
       #     {
       #       type: 'bubble',
       #       hero: {
       #         type: 'image',
       #         url: url + '/assets/course/tokyo-turf-2000.jpg',
       #         size: 'full'
       #       },
       #       body: {
       #         type: 'box',
       #         layout: 'vertical',
       #         contents: [
       #           {
       #             type: 'text',
       #             text: '東京 芝 2000m',
       #             size: 'xl',
       #             weight: 'bold',
       #             wrap: true
       #           },
       #           {
       #             type: 'text',
       #             text: 'クラスが上がるにつれ、スローで流れても逃げ残りが難しくなり差しが決まりやすくなる。\n 多頭数の場合は外枠不利。',
       #             size: 'sm',
       #             weight: 'bold',
       #             wrap: true
       #           }
       #         ]
       #       },
       #       styles: {
       #         hero: {
       #           backgroudColor: '#ffffff'
       #         }
       #       }
       #     }
       #   ]
       # }
        contents = [
          {
            type: 'bubble',
            hero: {
              type: 'image',
              url: url + '/assets/course/tokyo-turf-2000.jpg',
              size: 'full'
            },
            body: {
              type: 'box',
              layout: 'vertical',
              contents: [
                {
                  type: 'text',
                  text: '東京 芝 2000m',
                  size: 'xl',
                  weight: 'bold',
                  wrap: true
                },
                {
                  type: 'text',
                  text: 'クラスが上がるにつれ、スローで流れても逃げ残りが難しくなり差しが決まりやすくなる。\n 多頭数の場合は外枠不利。',
                  size: 'sm',
                  weight: 'bold',
                  wrap: true
                }
              ]
            }
          },
          {
            type: 'bubble',
            hero: {
              type: 'image',
              url: url + '/assets/course/tokyo-turf-2000.jpg',
              size: 'full'
            },
            body: {
              type: 'box',
              layout: 'vertical',
              contents: [
                {
                  type: 'text',
                  text: '東京 芝 2000m',
                  size: 'xl',
                  weight: 'bold',
                  wrap: true
                },
                {
                  type: 'text',
                  text: 'クラスが上がるにつれ、スローで流れても逃げ残りが難しくなり差しが決まりやすくなる。\n 多頭数の場合は外枠不利。',
                  size: 'sm',
                  weight: 'bold',
                  wrap: true
                }
              ]
            }
          }
        ]
      end
    end

  end
end
