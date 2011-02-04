# Nancy
## your sleek and versatile time and project manager
A detailed description of Nancy comes soon...

## Current status
  - Basic management features for Customers, Projects and Timemanagement are finished.
	- Interface design is almost done.
  - TDD with Cucumber is written (some scenarios are tagged with @wip)
  - Devise as authentication solution is integrated.
  - Currently i've written the Stylesheets with LessCSS (mostly the same like SASS).
  - Admin/Settings section
  - Mobile-Layout based upon jquery-mobile-

## Further goals
  - More features for Customers, Projects and Timemanagement-
  - Role-based authorization with CanCan and Devise-
  - Add AJAX for better user experience-
  - Currently I've written only cucumber tests, specs not yet implemnted but coming soon.
  - Sign up via oauth (facebook)-
  - l18n

## A selection of gems I used
  - TDD with Cucumber and RSpec
  - factory_girl, pickle, faker and email_spec for better testing
  - Compass-Framework with HAML & SASS
  - Authentication with Devise (on the edge) and omniauth
  - jQuery-Mobile Framework

##Getting Started
At first install all gems `bundle install`

and setup the database with `rake db:migrate`

If you would like to start with a some auto-generated data, run `rake db:seed` - Take a look into ./spec/factories.rb for your generated User account


**You need to set your SMTP-Server Settings for sending mails with Devise.**

Take a look into `./config/initzializers/setup_mail.rb` and `./config/application.rb`. There you need to set your smtp-login and current URL as ENV-var or via direct input.

## Demo
You can find a Demo at [Heroku](http://nancy.heroku.com "Nancy at Heroku")