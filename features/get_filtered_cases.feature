Feature: GET filtered cases
  As an API client
  I want to be able to get case data filtered by type
  So that I can present them to my users

  Scenario: Request all CMA "Mergers" cases
    Given there are registered documents
    When I GET "/finders/cma-cases/documents.json?case_type[]=mergers"
    Then I receive the following response
    """
      {
        "results": [
          {
            "title": "Heathcorp / Druginc merger inquiry",
            "slug": "cma-cases/healthcorp-druginc-merger-inquiry",
            "opened_date": "2003-12-30",
            "closed_date": "2004-03-01",
            "summary": "Inquiry into the Healthcorp / Druginc merger",

            "market_sector": {
              "value": "pharmaceuticals",
              "label": "Pharmaceuticals"
            },
            "case_type": {
              "value": "mergers",
              "label": "Mergers"
            },
            "outcome_type": {
              "value": "ca98-infringement-chapter-i",
              "label": "CA98 - infringement Chapter I"
            },
            "case_state": {
              "value": "closed",
              "label": "Closed"
            }
          }
        ]
      }
    """

  Scenario: No Mergers documents available
   Given there are no registered "mergers" documents
    When I GET "/finders/cma-cases/documents.json?case_type=mergers"
    Then I receive the following response
    """
      {
       "results": []
      }
    """

  Scenario: Filter by opened date
    Given there are registered documents
    When I GET "/finders/cma-cases/documents.json?opened_date=2006"
    Then I receive all documents with an opened date in "2006"

  Scenario: Filter by single values over mutiple fields
    Given there are registered documents
    When I GET "/finders/cma-cases/documents.json?outcome_type=ca98-infringement-chapter-i&case_type=closed"
    Then I receive all "closed" documents with outcome "ca98-infringement-chapter-i"
