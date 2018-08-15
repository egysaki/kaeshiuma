task src_path_modify: :environment do
  agent = Mechanize.new

  Rails.logger.info "pathを修正します"
  Horse.all.each do |h|
    h.update!(src_path: "/assets/horse/#{h.name}.jpg")
  end
end
