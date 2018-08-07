task import_course_info: :environment do

  Rails.logger.info "コースを登録を開始します。"

  list = %w(東京 札幌 函館 福島 新潟 中山 中京 京都 阪神 小倉)
  list.each do |name|
    Course.create(name: name)
  end
  
  Rails.logger.info "コースを登録が完了しました。"
end
