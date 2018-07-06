class HorseInfoScrapingJob <ActiveJob::Base
  @queue = :high

  def self.perform(options = {})
    ActiveRecord::Base.clear_active_connections! unless Rails.env.test?
    options = HashWithIndifferentAccess.new(options)

    Rails.logger.info "馬の情報を取得します。"
  end

end
