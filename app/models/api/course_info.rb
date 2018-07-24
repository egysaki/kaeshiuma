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
                if distance.include?('in')
                  text: "#{@name} #{distance.to_s.split(/-/)[0]}m 内回り",
                elsif distance.include?('out')
                  text: "#{@name} #{distance.to_s.split(/-/)[0]}m 外回り",
                else
                  text: "#{@name} #{distance.to_s}m",
                end
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
      }
    end

    def self.course_defined(course)
      @info = nil
      @image_path = '/assets/course/'
      @name = nil
      if course =~ /^東京芝$/
        @info = {'1400': 'test',
                 '1600': 'test',
                 '1800': 'test',
                 '2000': "クラスが上がるにつれ、スローで流れても逃げ残りが難しくなり差しが決まりやすくなる。\n 多頭数の場合は外枠不利。",
                 '2300': 'test',
                 '2400': 'test',
                 '2500': 'test',
                 '3400': 'test'
                }
        @image_path = @image_path + 'tokyo-turf-'
        @name = '東京 芝'
      elsif course =~ /^札幌芝$/
        @info = {'1200': "向う上面はずっとのぼりが続く。 \n 距離的に逃げ・先行有利だが、テンが長く競り合うと差し馬が台頭することもある。外枠の先行馬は割引が必要。",
                 '1500': "スタートから斜めに走るためテンは速くならない。内枠の逃げ・先行馬が中心となり、外枠の馬、追い込み脚質の馬は不利。 \n 日本で唯一施行されている距離で、好走歴のある馬は注意。",
                 '1800': "1コーナーまでの直線距離が短く、先行争いはやや激しくなるが、比較的ゆったりとしたペースになりやすい。 \n この距離に限らず札幌競馬場は小回りコースかつコーナー角度が緩いため、直線入り口までに好位のポジションを取りやすい逃げ・先行馬が有利。",
                 '2000': "基本的には、逃げ・先行有利だが道中のペースが緩みすぎるとマクリが決まることもある。 \n ペースが落ち着くので、瞬発力勝負になりやすく、クラスが上がるにつれ差しが決まりやすくなる。\n 多頭数の場合は外枠不利。",
                 '2600': "最初の先行争いはやや激しくなるがペースは落ち着きやすく、勝負どころまでロスなくどれだけ脚を溜められるかが重要。 \n 洋芝かつ6つのコーナーを回るためかなりスタミナが必要で、外枠の馬は不利。"
                }
        @image_path = @image_path + 'sapporo-turf-'
        @name = '札幌 芝'
      elsif course =~ /^札幌ダート$/
        @info = {'1000': "コーナーが緩やかで直線距離が短いため逃げ・先行馬が有利。 \n ハイペースになっても前が止まらず、後方一気で差し切るのは難しい。",
                 '1700': "基本的には、逃げ・先行有利だが、好位から長くいい脚を使った馬が馬券に絡みやすい。 \n マクリもよく決まり、直線入り口で前のポジションにいないと厳しい。",
                 '2400': "長丁場だが瞬発力勝負にはなりにくく、ある程度速い流れからの持久力勝負になる。 \n 先行馬が有利であり、4コーナー後方からでは届かないことが多い。"
                }
        @image_path = @image_path + 'sapporo-dirt-'
        @name = '札幌 ダート'
      elsif course =~ /^新潟芝$/
        @info = {'1000': "直線のみのコースだが、穏やかな坂が存在する。残り4ハロン時点で半数以上が脱落し、5ハロン目は残った馬による粘り合いになる。 \n 芝の傷みから開催後半は外枠が有利となる。追い込みは決まりにくいが中団からなら十分差し届く。",
                 '1200': "test",
                 '1400': "test",
                 '1600': "test",
                 '1800': "test",
                 '2000-in': "test",
                 '2000-out': "test",
                 '2200': "test",
                 '2400': "test"
                }
        @image_path = @image_path + 'niigata-turf-'
        @name = '新潟 芝'
      end
    end

  end
end
