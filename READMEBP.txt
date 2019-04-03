-ACCESS-
$ rails s  (localhost:3000)
heroku -> https://brockpedia.herokuapp.com

-BUILDNOTES/FEATURES-
 -removed 'markdown' from wiki index view
 -FIGARO gem - automatically created config/application.yml and modified .gitignore to include application.yml
 -DEVISE gem for login authentication(email confirmation)
 -PUNDIT gem for role authorization
 -STRIPE gem for credit card processing
 -FAKER gem for fake data generation via seed
 -REDCARPET gem for markdown capability
 -SENDGRID(addon) in production(heroku) - no local sendgrid ruby
  -didnt have to go to sendgrid for production(heroku). got USERNAME/PASSWORD from heroku console(see heroku notes) and plugged into config/application.yml

-ISSUES-
 *after creating wiki screen has update and delete buttons - a little strange
 *members can delete each others wiki - brockcp deleted brockpatterson
application controller
#when :show removed -> click on wiki and must login.
#when :index removed -> home disappears

-USERS-
 -check db/seeds.rb for seed configuration
 brockcp@me.com/helloo <dev only)
 brockpatterson@gmail.com/helloo (dev-only)

-LOG-
