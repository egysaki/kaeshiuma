task horse_info_scraping: :environment do
  agent = Mechanize.new

  Rails.logger.info "pathを修正します"
  Horse.all.each do |h|
    h.update!(src_path: "/assets/horse/#{horse.name}.jpg")
  end
end
