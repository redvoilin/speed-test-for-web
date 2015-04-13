require 'rspec'
require 'selenium-webdriver'
require File.expand_path('../../DB/database_mysql',__FILE__)
require File.expand_path('../../object/page_object',__FILE__)
require File.expand_path('../../common/common',__FILE__)

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
    @wait.until{ isPageLoaded(@browser) }
    @browser.find_element($object["articles_page"]["new_article_link"]).click
    @wait.until{ isPageLoaded(@browser) }
    title = "title" + Time.now.to_s
    body = "body" + Time.now.to_s
    @browser.find_element($object["articles_new_page"]["article_title_text"]).send_keys title
    @browser.find_element($object["articles_new_page"]["article_body_text"]).send_keys body
    @browser.find_element($object["articles_new_page"]["article_commit_button"]).click
    article = Article.where(title: title).first
    expect(article.body).to eq body
  end

  it "应该能成功查看博文详情" do
    @browser.get @uri + "articles"
    @wait.until{ isPageLoaded(@browser) }
    @browser.find_element($object["articles_page"]["article_show_link"]).click
    @wait.until{ isPageLoaded(@browser) }
    current_url = @browser.current_url
    id = (/\d+/.match current_url)[0]
    article = Article.find id
    title = @browser.find_element($object["article_show_page"]["title_content"]).text
    body = @browser.find_element($object["article_show_page"]["body_content"]).text
    expect(title).to eq "Title: " + article.title
    expect(body).to eq "Body: " + article.body
  end

  it "应该能成功修改博文" do
    @browser.get @uri + "articles"
    @wait.until{ isPageLoaded(@browser) }
    @browser.find_element($object["articles_page"]["article_edit_link"]).click
    @wait.until{ isPageLoaded(@browser) }
    title = "title" + Time.now.to_s
    body = "body" + Time.now.to_s
    @browser.find_element($object["articles_edit_page"]["article_title_text"]).clear
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

  it "应该能成功删除博文" do
    @browser.get @uri + "articles"
    @wait.until{ isPageLoaded(@browser) }
    article_title = @browser.find_element($object["articles_page"]["article_title"]).text
    @browser.find_element($object["articles_page"]["articles_destroy_link"]).click
    @browser.switch_to.alert.accept
    sleep 1
    article = Article.where(title: article_title).first
    expect(article).to eq nil
  end
end