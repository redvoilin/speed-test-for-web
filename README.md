# speed-test-for-web

speed test for web是一个使用ruby开发用于web测试的框架，基于ruby的rspec，一些测试用例中公用的方法可以放到common目录下，DB目录下存放和数据库库相关的代码，object目录下的page_object.yml文件存放界面元素，speed test for web使用activerecord作为ORM，使代码更加清晰易懂

spec目录下存放自动化用例，test_spec.rb是一个样例，可以对 https://github.com/redvoilin/blog 这个项目进行测试

先要安装所需gem

    gem install rspec
    gem install selenium-webdriver

运行测试脚本
    
    cd "speed test for web"
    rspec

如果需要连接mysql，需要通过下面命令安装相应gem 
    
    gem install mysql2
    gem install activerecord 

如果连的是sqlserver，需要通过下面命令安装相应gem
    
    gem install tiny_tds
    gem install activerecord-sqlserver-adapter

相关的资料
    
    rspec：http://rspec.info/

    active record: http://guides.rubyonrails.org/association_basics.html
