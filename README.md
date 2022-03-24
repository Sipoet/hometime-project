# hometime-project

## how to install
* install ruby management rvm/rbenv, prefer rbenv
* git clone this project
* install ruby 3.1.1 with your ruby management
  * in rbenv `rbenv install 3.1.1`
* install bundler `gem install bundler`
* run in console `bundle install`
* create & migrate db `bundle exec rails db:migrate`
##  how to run
* run server in development `rails s`
## how to display documentation
* it used rswag for self documentation and swagger ui for GUI
* to display documentation:
  * run server `rails s -p 3000`
  * open in browser `http://localhost:3000/api-docs`
