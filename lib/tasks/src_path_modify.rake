task src_path_modify: :environment do
  agent = Mechanize.new

  Rails.logger.info "pathを修正します"
  Horse.where.not('src_path LIKE ?', '%horse/2%').each do |h|
    next if h.link.blank?
    p h.name
    h.update!(src_path: "/assets#{h.link.chop}.jpg")
  end
end
