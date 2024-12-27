Feature: App starts

    Scenario: Start App
        When I start my App
        Then I should see a loader
        And then the text "Freenance"