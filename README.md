# README

In this project you'll be using Ruby on Rails with Postgres to create a simple web UI to display data from a database.

Users for this site are called ```Players``` who should get ```Offers``` depending on their ```OffersTargets```.

## Prerequisities
  - Ruby 2.6 installed.
  - Postgres installed.
    * http://postgresapp.com/
    * http://postgresapp.com/documentation/configuration-general.html
    
## Setup

* Install gems

  ``bundle install``
  
* Create the database

  1. Run `psql` in Terminal or `Open psql` from the Postgres.app status menu.
  2. `\du`
  2. `CREATE USER dev;`
  3. `CREATE DATABASE "take_home_rails_im_project_development" WITH OWNER dev;`
  4. `\q`

* Initialize the database
  1. Create tables:  ``rake db:load:schema``
  2. Populate your DB:  ``rails db:seed``

* Run the Rails server : ``rails s``

## Your Task:

 * Create a simple table in a view called IM Offers
 * This table should have the following columns:
   - Offer Description
   - Offer Target age
   - Offer Target gender
   
 * Create another a second table in the view for Players with the following columns:
    - First Name
    - Gender
    - Age

 * Choosing a Player from the table should filter the Offers table according to the selected Player's age and gender.

### Notes:
  For the views feel free to use any web development framework you're most familiar and feel comfortable.


### Bonus points:
  - Adding Test Units
  - Enhance the web views
  - Anything else you would want to show off your skills on :)


### Project Submission:
To submit your project, do one of the following:
  - Zip up the code and email it back.
  - Fork the repo in Github, commit your code, then email us a link to the repo.