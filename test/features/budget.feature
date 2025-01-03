Feature: Budget

    Scenario: First budget
        When I start my App
        And I wait for the loading to finish
        Then I should already have a budget
        And I should see an envelope

    Scenario: First envelope
        When I start my App
        And I wait for the loading to finish
        And I tap on the envelope
        Then I should see an operation of 500.0 €