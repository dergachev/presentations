<div style="position: absolute; height: 97%; width: 100%;">
  <h2 style="margin:30px auto 50px 0px; font-size:1.8em; font-weight:bold; width: 90%; text-align: center">
    Test Driven Drupal Upgrades
  </h2>
  <table style="width: 90%"><tr>
    <td style="font-size:0.7em; text-align: center; width:50%;">
      <div style="font-size:1.2em; font-weight:bold;">Alex Dergachev</div>
      <div> alex@evolvingweb.ca </div>
      <div> github.com/dergachev </div>
      <div> twitter.com/dergachev </div>
      <div> drupal.org/u/evolvingweb </div>
    </td>
    <td style="font-size:0.7em; text-align: center; width:50%;">
      <div style="font-size:1.2em; font-weight:bold;">Dave Vasilevsky</div>
      <div> vasi@evolvingweb.ca </div>
      <div> github.com/vasi </div>
      <div> twitter.com/djvasi </div>
      <div> drupal.org/u/vasi </div>
    </td>
  </tr></table>

  <p><img src="img/ew-good.png" style="height:130px; margin: 10px 0 0 0; position: absolute; bottom: 0;"></p>
</div>

--end--

## Outline

* __About us__ [3m]
* __Intro__ [2m]
* __Basics__: [10m]
  * Minor Updates (3m)
  * Major Core Upgrades (4m)
  * Testing (3m)
* __Tools__: [6m]
  * behat (3m)
  * CircleCI (2m)
  * docker	(1m)
* __drupal-docker-marriage demo__ [8m]
* __Case study__: McGill Courses and Programs D7 [18m]
  * Description (7m)
  * Solutions (4m)
  * Docker (2m)
  * SiteDiff (5m)
* __SiteDiff demo__ [5m]

--end--

## About Evolving Web

* Drupal development, consulting and training since 2007
* Very involved with the Drupal community
* Specialties
  * Large, scalable infrastructure and deployments
  * Multilingual content management
  * Apache Solr search interfaces
  * Content import and synchronization
  * Custom theme development
  * Custom module development
  * Search engine optimization for Drupal (SEO)
  * Integration with legacy systems
  * Expert Drupal training
* Based in Montreal, clients in Canada and USA

--end--

![](img/ew-projects.png)

--end--

## Drupal training program

<img src="http://evolvingweb.ca/sites/default/files/styles/large/public/_Q4A1828_0.jpg" width="25%" style="float: right; margin-left: 40px; margin-right: 20px" />

* Public: Montreal, Ottawa, Toronto, DC Munich, NJ, NYC, Boston
* Private: Health Canada, Parks Canada, Tourism Quebec, Trent U, McGill U
* Enterprise teams, dev shops, remote

--end--

## About the speakers

* Alex co-founded Evolving Web straight out of undergrad
* Dave was there to show us version control and Linux
* Besides doing Drupal projects since 2008...

--end--

## Introduction

* Upgrades are important for security
  * Security bugs are constantly found in Drupal and Drupal modules
  * Eg: Drupalgeddon (SA-CORE-2014-005) fixed in 7.32
* Upgrades bring new features
  * Drupal 7 has many performance improving features over D6
  * Webform 4 brings token support
* After Drupal 8 is released, Drupal 6 will become unsupported!

--end--

## Introduction

* Many Drupal developers aren't great at upgrading. Why?
  * Not everyone knows how
  * It can take time
  * We're afraid of regressions
  * We hate manual testing

--end--

## How to change

* Learn how to do upgrades
* Good tools make it easier and faster
* Testing makes it safe

--end--

## Minor updates vs. major upgrades

* Minor updates: 7.35 -> 7.36
  * Modules need updates too!
  * Perform these as often as possible, to keep up with security
* Major upgrades: 6.28 -> 7.36
  * Brings many, many new features and opportunities
  * Necessary before D6 is obsolute

--end--

## Minor update basics

* When to update: Use the Drupal Security Advisories mailing list: https://www.drupal.org/security
  * Or use the update module
* Where to update: In staging
  * Never do an update for the first time in production, you don't know if anything will break
* Watch out for hacks or patches to your modules!
  * Use the ```hacked``` module to find them

![](img/update-module.png)

--end--

## Minor update basics

* How to update in place:
  * ```drush pm-updatestatus``` to list available updates
  * ```drush pm-update``` to perform updates
* For real sites in production:
  * Perform manual update on dev/staging, test
  * Commit
  * Test updated repo on staging (updb!)
  * Deploy on prod
* Update hooks
  * Keep database in sync with versions of code
  * Eg: new column in database; rename variable
  * Running them: ```update.php``` or ```drush updb```

--end--

## Major upgrade basics

There are is no such thing as a basic major upgrade.

--end--

## Major upgrade basics

* Major upgrades can be harder than a site rebuild
  * APIs can change in ways that aren't backwards-compatible
  * Modules may not be updated yet, or at all
* We are talking about D6 to D7
  * Not clear whether it's possible to upgrade D7 to D8
  * D8 might require use of migrate module instead of update hooks

--end--

## Major upgrade basics

Before you can start the upgrade (still in D6):

* Update core and ALL contrib modules to latest d6 version
* Defeaturize
* Cleanup and fix bugs
* Disable all contrib and optional modules
* If modules have bad upgrade path, may need to uninstall
* Switch to core theme (garland)

--end--

## Major upgrade basics

Perform the upgrade:

* Update code of core and remaining modules to highest D7 version
* Run `drush updb`
* Use content_migrate for CCK->fields upgrade path
* Reenable and test contrib modules
  * Iterate on upgrading code and testing
  * Often need to find alternatives (popups -> references_dialog)
* Reenable and test custom modules
  * Start with coder upgrade
* Restore project-specific theme
* Adjust site as necessary to rebuild missing functionality
  * Lots of misc testing, development, database tweaks

--end--

## Testing basics

* Unit testing
* Integration testing
* UI testing
  * behat
* Continuous integration

--end--

## Unit testing

* Fast, good for standalone functions
* Use fixtures for testing
* D7: SimpleTest (DrupalUnitTestCase)
* D8: PHPUnit
* Contrib module's unit tests won't help you much for updates
* Good for custom modules

--end--

## Integration testing

* SimpleTest (DrupalWebTestCase)
* Powerful Drupal integration: Enable modules, create content, add users...
* By default, tests your module in isolation
  * Or tight coupling, hard to maintain
* Much slower, needs to site-install for each test
* Can't test things like JavaScript, CSS

--end--

## UI testing

* Tests your site by controlling a real browser
* Very powerful and thorough
* Eg: Selenium, CasperJS, behat
* Great replacement for manual testing

--end--

## Behat

[behat](http://docs.behat.org) and its [Drupal extension](https://behat-drupal-extension.readthedocs.org)

* Why BDD?
  * Testing will be ready for upgrades!
* Why use behat?
  * UI testing
  * Drupal integration
  * Easily understood tests

--end--

## behat scenarios

Here's an example of a test for behat:

    Scenario: Show author on hover
      Given I am viewing an "article" content:
      | title | author          | body  |
      | Lorem | bob@example.com | Ipsum |
      When I hover over the "author" region
      Then I should see the text "Bob"

Here's how we implemented the "hover" rule above, in a custom behat context:

    /**
      * @When I hover over the :region region
      */
    public function iHoverOverRegion($region) {
      getRegion($region)->mouseOver();
    }

--end--

## behat stack

<pre class="nocode" style="font-size: 30px;">
Behat's Gherkin language
Behat PHP contexts ---
Mink                 | Drupal extension drivers
Selenium
Chrome
</pre>

--end--

## CI

* Tests can be slow
* It's easy to forget to run them
* **Continuous integration**
  * Run your tests automatically for every commit
  * Usually uses a build server
  * Reports on the results
  * For upgrades, best with Test-Driven Development

--end--

## CircleCI

We use [CircleCI](http://circleci.com) for our continuous integration:

* Integrates with GitHub branches and pull requests
* Email notifications when something breaks
* Catches very unexpected bugs, eg: servers disappearing, unmaintained packages
* Allows use of docker, so test environment is consistent with dev/prod

--end--

## Docker

* Easily build and run virtualized containers
* Easy to spin up an exact copy of your site
  * If something breaks, just spin it up again
  * This is very useful for minor updates!
* Consistent environment in dev/staging/prod

--end--

## CircleCI & Docker

CircleCI is configured with a circle.yml file:

<pre class="prettyprint lang-yaml">
machine:
  services:
    - docker

dependencies:
  override:
    - docker build -t myproject .
    - docker run -p 9022:22 myproject

test:
  override:
    - "ssh -p 9022 drupal@localhost 'cd /var/www && drush test-run'"
</pre>

--end--

## Behat, CircleCI, Docker demo

![](img/pull-request-screenshot.png)

[github.com/evolvingweb/drupal-docker-marriage](https://github.com/evolvingweb/drupal-docker-marriage)

[Demo notes](https://github.com/dergachev/presentations/blob/gh-pages/drupalcon-la-upgrades/demo-marriage.md)

--end--

## D7 upgrade case study

* Project description
* Challenges
* Solutions
* Tools
  * Docker for build automation
  * PHPUnit and SiteDiff for testing

--end--

## D7 upgrade case study

<img src="img/coursecal-home.png" width="45%" style="float: right; margin-left: 40px; margin-right: 20px" />

* McGill University's Course Calendar
* "Academic Catalog": Programs, Courses, and University Regulations
* Legal documents, course schedules, metadata, cross-referencing
* Search-driven UI
* Buckets of imported records

--end--

## Search-driven UI

<img src="img/coursecal-search.png" width="45%" style="float: right; margin-left: 40px; margin-right: 20px" />

* Custom search tabs containing nested facets
* Section specific search pages in menus
* apachesolr-6.x-2.x -> Search API

--end--

## Logically nested menus

<img src="img/coursecal-faculty.png" width="40%" style="float: right; margin-left: 40px; margin-right: 20px" />

* For users, consistent global menu tree with ~10k items
  * consistency between menus, breadcrumbs, URLs
* ~100s menu items in primary\_links, rest in various book menus
* Merged via custom code, using core menu\_tree\_page_data, menu\_block

--end--

## Complex data structure

* 70k node revisions per year; mostly imported from banner+documentum
* 15 content types, 170 field instances; cross-linked via node reference fields
* Custom input filters (auto-detection of course names in any HTML content)

--end--

## Hard to upgrade

* Lots of custom modules
  * Legacy, with 4 years of cruft, lots of coupling
  * Needed extensive refactoring before upgrading
* Legal requirement that data shown must be correct and complete
* Deliverable = upgrade script, not code + db dump
  * Must be able to re-run on prod database
  * Must also be adaptable for 4 previous years (separate DBs)
* Limited time and resources: 2 devs, 12 weeks

--end--

## Easier parts

* Around 20-30 contrib modules
* No auth users except admins
* Little dynamic content except via import scripts
* Evolving Web wrote the original code
* Disciplined client, no scope creep

--end--

## Harder parts

* Features have no upgrade path
* Client unable to provide complete dev environment
  * We had to deduce which contrib modules enabled, version
  * Missing some custom modules defining content types, modules, blocks
* Performance: 2 days to run content migrate
* Misc upgrade path bugs (entityreference, nodeblock, i18n)

--end--

## Technical solutions

* Test-driven refactoring first for sanity
* Content migrate tweaks for speed
* SiteDiff for correctness
* Docker for build process automation

--end--

## Refactor + unit testing

* PHPUnit tests for custom modules
* Feasible to make it work with D7 (autoloading vs manual)
* Use fixtures in your test (eg. for menu trees and nodes)
* Sometimes had to bootstrap drupal (eg. for input filters)
* Can't mock/swap drupal functions, need process isolation
* Refactor custom code to allow dependency injection of mocks

--end--


## Build process

* D6 deploy script
* D6 refactor adjustments
* D6 prepare (defeaturize, turn off non-core modules, change theme to bartik, pm-uninstall several modules)
* drush updb
* Enable modules, run contrib updb
* content migrate
* [menu\_adjustments.php](https://github.com/evolvingweb/coursecal-d7/blob/d7/build/upgrade/menu_adjustments.php)
* [d7\_adjustments.sh](https://github.com/evolvingweb/coursecal-d7/blob/d7/build/scripts/d7_adjustments.sh)
* [d7\_adjustments\_solr.sh](https://github.com/evolvingweb/coursecal-d7/blob/d7/build/scripts/d7_adjustments_solr.sh)

--end--

## Performance tweaks

* content\_migrate (submodule of CCK) is slow (~2 days)
  * One field record (delta) at a time, one node at a time, one value at a time
  * Prune the database (10% of the nodes, focused on 1 faculty, try to keep consistency)
  * [github.com/dergachev/content\_migrate\_tweaks](/https://github.com/dergachev/content_migrate_tweaks/)
  * Replaced with INSERT ... SELECT ... queries as >100x optimization
  * Validated with unit tests, table checksums, SiteDiff
* `drush php-script` vs `hook_update_N`

--end--

## Build automation reqs

* Easily deployed, consistent dev and test environments
* Checkpoints
* Caching
* Simplicity (bash)

--end--

## Docker

* Dockerfile build process:
* Bash-like
* Starts with clean Ubuntu image
* Installs all necessary packages: tomcat, solr, nginx, xhprof, xdebug, ...
* Runs our deploy scripts
* Caching
* Caveats (Makefiles, Linux, TIMTOWTDI)

--end--

## Testing requirements

* Ensure dev mirrors prod
* Ensure D6 refactoring changed nothing
* D7 should mostly mirror D6
* Mostly static HTML content
* Too big to test manually

--end--

## SiteDiff

[github.com/evolvingweb/sitediff](https://github.com/evolvingweb/sitediff)

* Downloads subset of pages from _before_ and _after_
* Computes diff of HTML
* Cleans up spurious changes, like absolute domains
* Reports changes via command-line UI and web report
* Break down huge upgrade into simple tasks

--end--

## SiteDiff configuration

<pre class="prettyprint lang-yaml">
before_url: http://docker:9179
after_url: http://docker:9180
sanitization:
- pattern: http:\/\/[a-zA-Z0-9.:-]+
  substitute: __domain__
paths:
- /
- /about-us
- /user/3/track
</pre>

--end--

## SiteDiff output

![](img/sitediff-report.png)
![](img/sitediff-diff.png)

--end--

## SiteDiff

* Advantages:
  * Thoroughness
  * Black-box
  * Speed
* Limitations:
  * JavaScript
  * Dynamic content
  * Admin UI

--end--

## SiteDiff

SiteDiff turns out to be useful on many projects

* Refactorings
* Dev vs Prod
* Content migration
* Upgrades! Little should change

--end--

## SiteDiff demo

![](img/sitediff-screenshot.png)

[github.com/vasi/sitediff-update-demo](https://github.com/vasi/sitediff-update-demo)

[Demo notes](https://github.com/dergachev/presentations/blob/gh-pages/drupalcon-la-upgrades/demo-sitediff.md)

--end--

## Any questions?

* Evolving Web: [evolvingweb.ca](http://evolvingweb.ca)
* SiteDiff: [github.com/evolvingweb/sitediff](https://github.com/evolvingweb/sitediff)
* Demo of SiteDiff: [github.com/vasi/sitediff-update-demo](https://github.com/vasi/sitediff-update-demo)
* Demo of docker, behat, CircleCI: [github.com/evolvingweb/drupal-docker-marriage](https://github.com/evolvingweb/drupal-docker-marriage)
