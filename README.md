# README

In this project you'll be using Ruby on Rails connecting to Postgres DB.


Users for this site are called ```Players``
Players should get ```Offers`` depending on their ``OffersTargets``

## Your Task (after creating the tables and populating with seeds mentioned bellow):

 * Create a simple table called IM Offers
 * This table should have the following columns:
   - offer Description
   - Offer Target age
   - Offer Target gender
 * Create a table for Players with the following columns:
    - gender
    - age
    - first_name

 * Choosing player from the table should filter the Offers table according to the player age and gender

### Notes:
  For view, feel free to use any language you're most familiar and feel comfortable.

### Project Submission:
  - Create a branch from master [yourname]-solution
  - Generate a PR when ready 

### Bonus points:
  Adding Test Units
  Impressive view
  Or anything else you would want to show off your skills on :)


* Ruby version
  2.6.6



* Database creation
  Install postgres

* http://postgresapp.com/
* http://postgresapp.com/documentation/configuration-general.html
* Run `psql` in Terminal or `Open psql` from the Postgres.app status menu:
  1. `\du`
  2. `CREATE USER dev;`
  3. `CREATE DATABASE "take_home_rails_im_project_development" WITH OWNER dev;`
  5. `\q`

Install gems

  ``bundle install``

* Database initialization

Creating tables:  ``rake db:migrate``
Run to populate your DB:   ``rails db:seed``

* Running the server : Rails s
