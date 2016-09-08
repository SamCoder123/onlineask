SeoHelper.configure do |config|
  config.skip_blank = false
  config.site_name = Setting.app_name
  config.default_page_description = "约霸 海外留学 在线问答 留学咨询 禁止色情"
  config.default_page_image = "#{Setting.domain}#{Setting.default_og_url}"
end
