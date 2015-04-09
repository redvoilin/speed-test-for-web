require 'rspec'
require 'selenium-webdriver'
require File.expand_path('../../DB/database_mysql',__FILE__)
require File.expand_path('../../object/page_object',__FILE__)

describe "博客" do 
  before :all do
    @browser = Selenium::WebDriver.for :firefox
    @browser.manage.window.maximize
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @uri = "http://localhost/"
    @browser.get @uri + "articles"
  end

  after :all do
    @browser.close
  end

  it "应该能成功发新博文" do
    @browser.find_element($object["articles_page"]["new_article_link"]).click
    title = "title" + Time.now.to_s
    body = "body" + Time.now.to_s
    @wait.until{ @browser.find_element($object["articles_new_page"]["article_title_text"]).send_keys title }
    @browser.find_element($object["articles_new_page"]["article_body_text"]).send_keys body
    @browser.find_element($object["articles_new_page"]["article_commit_button"]).click
    article = Article.where(title: title).first
    expect(article.body).to eq body
  end

  it "应该能成功查看博文详情" do
    @browser.get @uri + "articles"
    @browser.find_element($object["articles_page"]["article_show_link"]).click
    current_url = @wait.until{ @browser.current_url }
    id = (/\d+/.match current_url)[0]
    article = Article.find id
    title = @browser.find_element($object["article_show_page"]["title_content"]).text
    body = @browser.find_element($object["article_show_page"]["body_content"]).text
    expect(title).to eq "Title: " + article.title
    expect(body).to eq "Body: " + article.body
  end

  it "应该能成功修改博文" do
    @browser.get @uri + "articles"
    @browser.find_element($object["articles_page"]["article_edit_link"]).click
    title = "title" + Time.now.to_s
    body = "body" + Time.now.to_s
    @wait.until{@browser.find_element($object["articles_edit_page"]["article_title_text"]).clear}
    @browser.find_element($object["articles_edit_page"]["article_title_text"]).send_keys title
    @browser.find_element($object["articles_edit_page"]["article_body_text"]).clear
    @browser.find_element($object["articles_edit_page"]["article_body_text"]).send_keys body
    @browser.find_element($object["articles_edit_page"]["article_commit_button"]).click
    current_url = @browser.current_url
    id = (/\d+/.match current_url)[0]
    article = Article.find id
    expect(article.title).to eq title
    expect(article.body).to eq body
  end
end