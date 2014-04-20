[![Build Status](https://travis-ci.org/twizards/twitter-app.svg?branch=master)](https://travis-ci.org/twizards/twitter-app)
[![Code Climate](https://codeclimate.com/github/twizards/twitter-app.png)](https://codeclimate.com/github/twizards/twitter-app)
# Twitterapp

## Description

Twizardry is a Rails application that streams and visualizes Twitter data to help you get in touch with New York City.

## Screenshots

![heatmap](http://107.170.117.122/assets/heatmapshot-fa95de4c7fe3a055ddf6da1780921cdf.gif)
![twubbles](http://107.170.117.122/assets/twibbles-4d69b49ec6e2e2f1822714cec6685b6d.gif)

## Background

### Why did you want to make this app? 

Inspired by a passion for compelling information presentation and the enormity of the Twitter dataset, we set out to bring people closer through our code. For the sake of limiting our project scope, we chose to focus on increasing ambient awareness in New York City by displaying live-streamed, local tweets in three different ways.

### What was your development process like?

We started out with a single twitter data stream open, and decided to use geolocation data to create a heatmap after being inspired by [Graffito](graffito.herokuapp.com), a rails app that came out of the Flatiron School Brooklyn Fellowship last semester. From there we added more twitter streams and scaled up the backend server technology as necessary in order to create more visualizations. The [D3 Javascript library](d3js.org) was an incredible resource for us.

## Features

### HivePulse

Using geolocation data provided by Twitter and Google Maps API, HivePulse displays the heartbeat of the city on a heat map overlay. We chose this visualization in part because Twitter's dataset provides uniquely comprehensive geolocation tagging.

### Twubbles

New York can be a scary, lonely place. You may find yourself closed off and trapped in a bubble of self-doubt. But you're not alone. Everyone experiences doubt, pain, suffering, and heartbreak. Twubbles is a visualization that shows other New Yorkers having a little twubble right now too.

### The Techo Chamber

The tech scene in New York can be very insular, and sometimes feels like a bit of an echo chamber, with everyone concerned about hot new trends. Embracing that, this visualization compares how much people are tweeting about a few top tech companies in a variety of ways.

## Usage

Go to [our site](http://107.170.117.122) and check out our visualizations!

## Development/Contribution

If you'd like to submit a pull request please adhere to the following:

Your code must be tested. Please TDD your code!
No single-character variables
Two-spaces instead of tabs
Single-quotes instead of double-quotes unless you are using string interpolation or escapes.
General Rails/Ruby naming conventions for files and classes.

## Future

Right now our primary focus is to improve our current visualizations and optimize for performance. We are going to monitor this project with NewRelic to find bottlenecks, and are considering whether or not to migrate to Puma. We plan to increase test coverage and pay down some of our technical debt by refactoring the code base.

## Authors
Built by [Corbin Page](http://www.linkedin.com/in/corbintpage),
[Joan Soskin](http://www.linkedin.com/in/joansoskin),
[William Jeffries](http://www.linkedin.com/in/williamjeffries), and
[Daniel Kronovet](http://www.linkedin.com/in/dkronovet), students at the [Flatiron School](http://flatironschool.com/) in New York.

## License

This application is MIT Licensed. See [LICENSE](https://github.com/twizards/twitter-app/blob/master/LICENSE) for details.
