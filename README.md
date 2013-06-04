[![Code Climate](https://codeclimate.com/github/raphweiner/elefeely-api.png)](https://codeclimate.com/github/raphweiner/elefeely-api)

### Elefeely

This first individual gSchool project imposed a single requirement: create an API and gem to consume it.  I chose to take a service-oriented design approach and built four different components: a primary (rails-api) app, a twilio service (rails-api) app, a gem for the twilio service to communicate with the primary app, and a front-end backbone.js app.

#### Elefeely API
The primary API connects to a postgres database and provided API endpoints for the Twilio interface app and Backbone app.

#### Elefeely Twilio Interface

Repo: [http://github.com/raphweiner/elefeely-twilio-interface](http://github.com/raphweiner/elefeely-twilio-interface)

The Twilio interface app runs a cron job that retrieves a list of verified numbers from the primary API and kicks off background task to send SMS via the Twilio gem, and handles callbacks from Twilio.

#### Elefeely UI

Repo: [http://github.com/raphweiner/elefeely-ui](http://github.com/raphweiner/elefeely-ui)

The barebones (pun intended :) backbone.js app communicates with the primary app endpoints and uses canvas to provide a graph of (personal and collective) feelings.

#### Elefeely Gem

Repo: [http://github.com/raphweiner/elefeely](http://github.com/raphweiner/elefeely)

Lastly, the gem is used internally by the Twilio interface app to sign and send requests to the primary app.
