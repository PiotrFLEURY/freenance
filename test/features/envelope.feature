Freature: Envelope

    Scenario: Create an envelope
    Given I start my App
    And I wait for the loading to finish
    When I create a new envelope named "Mon enveloppe" with 42.0 amound
    Then I should see the envelope screen openning
