module FlapybooksHelpers

  # use 'localhost' in development
  # use `config[:site][:url]` in production
  def site_url(path_or_resource, options_hash = {}.freeze)
    base_url = if build?
      config[:site][:url]
    else
       "http://#{config[:bind_address]}:#{config[:port]}"
    end

    base_url + url_for(path_or_resource, options_hash)
  end

  # Get product fullname, including `edition`
  # Only use in product pages
  def product_fullname(product) 
    name = product.data[:name]
    edition = product.data[:edition]

    return name if edition.nil?

    "#{name}（#{edition}）"
  end

  def product_purchase_url(product)
    @url ||= "#{config[:site][:fastspring_url]}/#{product.slug}"
  end

  ##################################
  ## Seo Meta Tags                ##
  ##################################
  def meta_tags
    @meta_tags ||= Hash.new
  end

  def set_meta_tags(meta_tags = {})
    self.meta_tags.merge! meta_tags
  end

  def display_meta_tags(default = {})
    result    = []
    meta_tags = default.merge(self.meta_tags)

    description = meta_tags.delete(:description)
    result << tag(:meta, name: :description, content: description) if description.present?

    twitter_tags = meta_tags.delete(:twitter)
    if twitter_tags.present?
      twitter_image = twitter_tags.delete(:image) 
      twitter_tags.each do |k,v|
        result << tag(:meta, name: "twitter:#{k}", content: v)
      end
    end
    if twitter_image.present?
      result << tag(:meta, name: 'twitter:image', content: twitter_image[:_])
      result << tag(:meta, name: 'twitter:image:alt', content: twitter_image[:alt])
    end

    og_tags = meta_tags.delete(:og)
    if og_tags.present?
      og_price = og_tags.delete(:price) 
      og_tags.each do |k,v|
        result << tag(:meta, name: "og:#{k}", content: v)
      end
    end
    if og_price.present?
      result << tag(:meta, name: 'og:price:amount', content: og_price[:amount])
      result << tag(:meta, name: 'og:price:currency', content: og_price[:currency])
    end

    result = result.join("\n")
    result.html_safe
  end
end
