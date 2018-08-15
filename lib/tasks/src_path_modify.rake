task src_path_modify: :environment do
  agent = Mechanize.new

  Rails.logger.info "pathを修正します"
  Horse.where('src_path LIKE ?', '%horse/horse%').each do |h|
    h.update!(src_path: "/assets/horse/#{h.name}.jpg")
  end
end
