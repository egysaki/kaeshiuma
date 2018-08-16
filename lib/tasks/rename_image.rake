task rename_image: :environment do
  Horse.where.not(src_path: nil, link: nil).each do |horse|
    system "mv ./app/assets/images/horse/#{horse.name}.jpg ./app/assets/images2#{horse.link.chop}.jpg"
    puts horse.name
  end
end
