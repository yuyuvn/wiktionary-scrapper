require 'nokogiri'
require 'open-uri'

@domain = "https://vi.wiktionary.org"


def get_data(url, output_file)
  r = open(@domain + url)
  page = Nokogiri::HTML(r)
  next_page = page.xpath('//div[@id="mw-pages"]/a[text()="Trang sau"]').first.attributes["href"].value rescue nil
  output = page.xpath('//div[@class="mw-category-group"]').map do |category|
    category.css('a').map(&:text).join("\n")
  end.join("\n") + "\n"

  f = File.open(output_file, "a+")
  f.write(output)
  f.close

  get_data next_page, output_file unless next_page.nil?
end

get_data  "/wiki/Th%E1%BB%83_lo%E1%BA%A1i:Danh_t%E1%BB%AB_ti%E1%BA%BFng_Vi%E1%BB%87t", "./output/noun.txt"
get_data  "/wiki/Th%E1%BB%83_lo%E1%BA%A1i:%C4%90%E1%BB%99ng_t%E1%BB%AB_ti%E1%BA%BFng_Vi%E1%BB%87t", "./output/verb.txt"
get_data  "/wiki/Th%E1%BB%83_lo%E1%BA%A1i:T%C3%ADnh_t%E1%BB%AB_ti%E1%BA%BFng_Vi%E1%BB%87t", "./output/adj.txt"
get_data  "/wiki/Th%E1%BB%83_lo%E1%BA%A1i:Ph%C3%B3_t%E1%BB%AB_ti%E1%BA%BFng_Vi%E1%BB%87t", "./output/adverb.txt"
get_data  "/wiki/Th%E1%BB%83_lo%E1%BA%A1i:Li%C3%AAn_t%E1%BB%AB_ti%E1%BA%BFng_Vi%E1%BB%87t", "./output/conjunction.txt"
get_data  "/wiki/Th%E1%BB%83_lo%E1%BA%A1i:%C4%90%E1%BA%A1i_t%E1%BB%AB_ti%E1%BA%BFng_Vi%E1%BB%87t", "./output/subject.txt"
get_data  "/wiki/Th%E1%BB%83_lo%E1%BA%A1i:Gi%E1%BB%9Bi_t%E1%BB%AB_ti%E1%BA%BFng_Vi%E1%BB%87t", "./output/adposition.txt"
get_data  "/wiki/Th%E1%BB%83_lo%E1%BA%A1i:Th%C3%A1n_t%E1%BB%AB_ti%E1%BA%BFng_Vi%E1%BB%87t", "./output/interjection.txt"
