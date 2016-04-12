# The Watcher
![alt tag](http://content.screencast.com/users/jakub.kubacki/folders/Jing/media/465abf6f-7674-4935-b38e-8e945154a49f/00000081.png)

[![](http://img.shields.io/travis/fantasygame/watcher.svg?style=flat-square)](https://travis-ci.org/fantasygame/watcher)
[![](http://img.shields.io/codeclimate/github/fantasygame/watcher.svg?style=flat-square)](https://codeclimate.com/github/fantasygame/watcher)

## [Check out our app](http://thewatcher.herokuapp.com/)

## General info

The purpose of this app is to manage watched TV shows.

Simple app to keep track of your progress in tv shows.
User can select watched shows and seen episodes.

App uses moviedb to show new episodes to watch and their description.

## Technologies

* Ruby on Rails 4.2.6
* Ruby 2.3.0
* Postgresql
* HAML
* Bootstrap 3
* Omniauth authentication
* Pundit authorization
* Continous deployment with Travis and Heroku
* Code Climate quality check

## Setup
### Clone repository
`git clone git@github.com:fantasygame/watcher.git`

### Download gems
`bundle install`

### Install database (postgresql)

Ubuntu: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04

OSX: http://postgresapp.com/

### Create postgresql superuser campaigns.

To do that you can use interactive psql command
`createuser --interactive`

### Copy config
`cp config/database.example.yml config/database.yml`

`cp config/application.example.yml config/application.yml`

### Setup database
`rake db:setup`

## Tests
We use RSpec 3 for backend testing.

## Development (fantasygame team)
* Make sure that you have your email and name set in git on your machine. It won't recognize your commits if you don't do this. https://help.github.com/articles/setting-your-email-in-git/
* Make sure to connect your machine to github by ssh https://help.github.com/articles/generating-ssh-keys/
* Don't fork the project. We use one-repo pull request approach for easy development.
* Every pull request is reviewed by the other team member. Make sure to fix any issue that is found.
* Every commit is reviewed by the other team member. Make sure to fix any issue that is found.
* We use rubocop to mantain high code quality. Make sure to follow its advices. Install rubocop plugin to your editor.
* Make your best to write tests for your code. You can check code coverage in codeclimate.
* We don't like merge commits. Use rebase. `bash git config --global branch.autosetuprebase always `

## Deployment
To deploy to production (heroku) just merge master to production branch via
`git push origin master:production`

## Contributing

If you make improvements to this application, please share with others.

* Fork the project on GitHub.
* Make your feature addition or bug fix.
* Commit with Git.
* Send the author a pull request.
* Please follow Ruby style guide available [here](https://github.com/bbatsov/ruby-style-guide) and rubocop.yml

If you add functionality to this application, create an alternative
implementation, or build an application that is similar, please contact
me and I’ll add a note to the README so that others can find your work.

## Authors

* Małgorzata Grobelska
* Jakub Kubacki
