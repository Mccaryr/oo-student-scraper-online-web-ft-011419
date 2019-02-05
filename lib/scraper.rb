require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []

    doc.css(".roster-cards-container").each do |profile|
      profile.css(".student-card a").each do |student_card|
        student = {}
        student[:name] = student_card.css(".student-name").text
        student[:location] = student_card.css(".student-location").text
        student[:profile_url] = student_card.attribute("href").value
        student_array << student
      end

    end
    #binding.pry
    student_array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

  result={}
  result[:profile_quote] = profile.css('div.profile-quote').text
  result[:bio] = profile.css('.bio-content .description-holder p').text
  profile.css('div.social-icon-container a').each do |href|
    link = href.attribute('href').value
    if link.match(/.linkedin.com/)
      result[:linkedin] = link
    elsif link.match(/.twitter.com/)
      result[:twitter] = link
    elsif link.match(/.github.com/)
      result[:github] = link
    else
      result[:blog] = link
    end
  end
  result
      end
end
