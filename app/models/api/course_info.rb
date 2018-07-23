module Api
  class CourseInfo

    def self.return_course_info(course, url)
      self.course_defined(course)
      return if @info.nil?

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
         #       url: url + @image_path + distance.to_s + '.jpg',
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
      @image_path = '/assets/course/'
      if course =~ /^東京芝$/
        @info = {'1400': 'test',
                 '1600': 'test',
                 '1800': 'test',
                 '2000': 'クラスが上がるにつれ、スローで流れても逃げ残りが難しくなり差しが決まりやすくなる。\n 多頭数の場合は外枠不利。',
                 '2300': 'test',
                 '2400': 'test',
                 '2500': 'test',
                 '3400': 'test'
                }
        @image_path = @image_path + 'tokyo-turf-'
      end
    end

  end
end
