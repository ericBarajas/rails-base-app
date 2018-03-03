# My Rails demo app

View demo online: http://tpl.optimacms.com

## Quick start

* Clone the git repo
```ruby
git clone https://github.com/maxivak/rails-base-app
```
or [download it](https://github.com/maxivak/rails-base-app/archive/master.zip)

* Change config/secrets.yml with your database settings
* Create MySQL database
* Import mysql dump from '__db' folder into database

* Run `bundle install`
* Run `rake db:migrate`

* Run `yarn install`
* Precompile assets 
```
RAILS_ENV=development rake assets:precompile
```

* run web server

* Access site `http://localhost:3000`

* Access admin area:
```
http://localhost:3000/admin
```
with credentials:
```
admin@example.com
password
```

* Change admin password


## Requirements

* Rails 5
* Ruby 2.4
* Mysql database
* Redis server
* Imagemagick (For uploading pictures)




## Documentation
[Wiki](https://github.com/maxivak/rails-base-app/wiki)


