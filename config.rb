# View all configurations: http://localhost:4200/__middleman/config/

# Site
config[:site] = {
  name: '笨鸟码书',
  url: 'https://flapybooks.com',
  email: 'hi@flapybooks.com',
  twitter: 'flapybooks',
  description: '笨鸟码书引进优秀的外文编程资料，翻译成流畅的中文，助力国内开发者成长。我们遵从精益出版策略，精益求精。我们的作品涵盖电子书和视频课，深受 2500+ 开发者的信赖。',
  fastspring_url: 'https://andor.onfastspring.com',
  tencent_cloud_public_host: 'https://flapybooks-public-1257356257.file.myqcloud.com',
  menu_items: {
    index: '首页',
    news: '新闻',
    contact: '联系',
    login: '登录'
  }
}

# Per-page layout changes
config[:layout] = 'default'
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Assets
config[:css_dir] = 'assets/stylesheets'
config[:fonts_dir] = 'assets/fonts'
config[:images_dir] = 'assets/images'
config[:js_dir] = 'assets/javascripts'
config[:sass_assets_paths] << Bootstrap.stylesheets_path

# Preview server
config[:bind_address] = '127.0.0.1'
config[:port] = '4200'

# Build
set :skip_build_clean do |path|
  path =~ /\.nojekyll|\.git/
end

ignore '*.sketch'

configure :build do
  activate :minify_css
  activate :gzip
  activate :asset_hash
end

# Products
activate :blog do |blog|
  blog.name = "products"
  blog.prefix = "products"
  blog.sources = '{title}.html'
  blog.permalink = '/{title}'
  blog.layout = 'product'
end

# Extensions
activate :directory_indexes
activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Others
page '404.html', :directory_index => false
