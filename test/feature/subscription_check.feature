Feature: Verify active Chargebee subscription
  As a user
  I want to confirm my subscription status
  So that I can access premium features

  Scenario: Check an active subscription by ID
    Given I am on the subscription screen
    And I enter the subscription id "sub_123456789"
    When I tap the check subscription button
    Then I see a subscription status of "active"
