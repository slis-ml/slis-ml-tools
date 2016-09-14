# -*- coding: utf-8 -*-

require 'rss'
require 'open-uri'
require 'nokogiri'


# NOTE : This is a constant
BASE_URL = 'https://slis-ml.github.io/feed.xml'



# parse_rss :: url(text) -> 
def parse_rss url
  response = open(url)
  rss = RSS::Parser.new(response).parse


  rss.items.each do |item|
    extract_date(item)
  end
  
end


# 
# NOTE : aim to return 3W (what, when, where)
#
# extract_date :: item(RSS::Rss::Channel::Item) -> title(string), date(datetime), place(string)
#
def extract_date item
  title = item.title
  body  = item.description.gsub(/\n/, '')

  date_string = 'undefined yet'
  place = 'undefined yet'


  date_candidate = body.scan(/\<h2.*?\>日時<\/h2><p>(.*?)<\/p>/)
  place_candidate = body.scan(/\<h2.*?\>場所<\/h2><p>(.*?)<\/p>/)


  unless date_candidate.empty?
    p date_candidate[0][0]
  end

  unless place_candidate.empty?
    p place_candidate[0][0]
  end


  # NOTE : this object (item) does not have
  #        a valid strucure to easily extract target datetimes.
  #
  # result = Nokogiri::HTML.parse(body, nil, 'utf-8')
  # p result.xpath('//h2').map(&:children)

  # return title, date, place
end


def update_slis_ml

end



parse_rss(BASE_URL)