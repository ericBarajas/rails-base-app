# My Rails demo app

View demo online: http://tpl.optimacms.com

## Quick start

* Clone the git repo
```ruby
git clone https://github.com/maxivak/rails-base-app
```
or [download it](https://github.com/maxivak/rails-base-app/archive/master.zip)

* Create database
* Import mysql dump from '__db' folder into database
* Change config/secrets.yml with your database settings

* Run `bundle install`
* Run `rake db:migrate`

* Run `yarn install`
* Precompile assets 'RAILS_ENV=development rake assets:precompile'

* Access site

* Access admin area:
```
http://localhost:3000/admin
webmaster@example.com
password
```

* Change admin password


## Requirements

* Rails ~> 4.2
* Ruby 2.1
* Redis server
* Imagemagick (For uploading pictures)




## Documentation
[Wiki](https://github.com/maxivak/rails-base-app/wiki)


