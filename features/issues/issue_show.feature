#-- copyright
# OpenProject is a project management system.
#
# Copyright (C) 2012-2013 the OpenProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

Feature: Issue textile quickinfo links
  Background:
    Given there are no issues
    And there is 1 project with the following:
      | name        | parent      |
      | identifier  | parent      |
    And I am working in project "parent"
    And the project "parent" has the following trackers:
      | name | position |
      | Bug  |     1    |
    And there is a default issuepriority with:
      | name   | Normal |
    And there is a role "member"
    And the role "member" may have the following rights:
      | add_issues  |
      | view_work_packages |
      | edit_work_packages |
    And there is 1 user with the following:
      | login | bob|
    And the user "bob" is a "member" in the project "parent"
    And there are the following issue status:
      | name        | is_closed | is_default |
      | New         | false     | true       |
      | In Progress | false     | false      |
    Given the user "bob" has 1 issue with the following:
      | subject     | issue1              |
      | due_date    | 2012-05-04          |
      | start_date  | 2011-05-04          |
      | description | Avocado Sali Grande |
    And I am logged in as "bob"

  @javascript
  Scenario: Watch an issue
    When I go to the page of the issue "issue1"
    Then I should see "Watch" within "#content > .action_menu_main"
    When I click on "Watch" within "#content > .action_menu_main"
    Then I should see "Unwatch" within "#content > .action_menu_main"
    Then the issue "issue1" should have 1 watchers

  @javascript
  Scenario: Unwatch an issue
    Given the issue "issue1" is watched by:
      | bob |
    When I go to the page of the issue "issue1"
    Then I should see "Unwatch" within "#content > .action_menu_main"
    When I click on "Unwatch" within "#content > .action_menu_main"
    Then I should see "Watch" within "#content > .action_menu_main"
    Then the issue "issue1" should have 0 watchers
