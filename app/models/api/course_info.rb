module Api
  class CourseInfo

    TOKYO_TURF = [1400, 1600, 1800, 2000, 2300, 2400, 2500, 3400]

    def self.return_course_info(course, url)
      self.course_defined(course)

      contents_body = []
      @info.each do |distance, detail|
        contents_body << {
          type: 'bubble',
          hero: {
            type: 'image',
            url: url + @image_path + distance.to_s + '.jpg',
            size: 'full'
          },
          body: {
            type: 'box',
            layout: 'vertical',
            contents: [
              {
                type: 'text',
                text: "東京 芝 #{distance.to_s}m",
                size: 'xl',
                weight: 'bold',
                wrap: true
              },
              {
                type: 'text',
                text: detail,
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
        #contents: [
         # @info.each do |distance, detail|
         #   {
         #     type: 'bubble',
         #     hero: {
         #       type: 'image',
         #       url: url + @image_path + disatance.to_s + '.jpg',
         #       size: 'full'
         #     },
         #     body: {
         #       type: 'box',
         #       layout: 'vertical',
         #       contents: [
         #         {
         #           type: 'text',
         #           text: "東京 芝 #{distance.to_s}m",
         #           size: 'xl',
         #           weight: 'bold',
         #           wrap: true
         #         },
         #         {
         #           type: 'text',
         #           text: detail,
         #           size: 'sm',
         #           weight: 'bold',
         #           wrap: true
         #         }
         #       ]
         #     }
         #   }
         # end
        #]
      }
    end

    def self.course_defined(course)
      @info = nil
      @image_path = nil
      if course =~ /^東京芝$/
        @info = {'1400': nil,
                 '1600': nil,
                 '1800': nil,
                 '2000': 'クラスが上がるにつれ、スローで流れても逃げ残りが難しくなり差しが決まりやすくなる。\n 多頭数の場合は外枠不利。',
                 '2300': nil,
                 '2400': nil,
                 '2500': nil,
                 '3400': nil
                }
        @image_path = '/assets/course/tokyo-turf-'
      end
    end

  end
end
