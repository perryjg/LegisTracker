Feature: Homepage description
  In order to keep abreast of recent events
  As a reporter
  I want to see latest events on the home page

@wip
Scenario: Home page lists recent bill status events
	When I visit the home page
	Then I will find the most recent bill status events

Scenario: Home page lists most recent votes
	When I visit the home page
	Then I will see the most recent votes

Scenario: Home page lists recent Senate RSS feeds
	When I visit the home page
	Then I will see the most recent Senate RSS feed items

Scenario: Home page lists recent House RSS feeds
When I visit the home page
Then I will see the most recent Home RSS feed items


