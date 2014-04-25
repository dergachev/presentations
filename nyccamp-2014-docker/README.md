<div style="position: absolute; height: 97%; width: 90%;">
<h2 style="margin:30px auto 100px auto; font-size:2.2em; font-weight:bold; float:right;">
  Test-Driven D7 Upgrades w/ Docker
</h2>
  <code style="float:right; font-size:0.7em; clear:both; text-align: right;">
    <div style="font-size:1.2em; font-weight:bold;">Alex Dergachev</div>
    <div> alex@evolvingweb.ca </div>
    <div> github.com/dergachev </div>
    <div> twitter.com/dergachev </div>
    <div> evolvingweb on drupal.org </div>
  </code>
<img src="resources/img/ew-good.png" style="height:130px; margin: 10px 0 0 0; position: absolute; bottom: 0;">
</div>

--end--

## Outline

* About the project
* Technical features
* Special challenges
* Solutions
* Docker tutorial
* Sitediff demo

--end--

## About the project

* McGill University's Course Calendar (aka Catalogue)
* Programs, Courses, and University Regulations
* Legal documents, course schedules, metadata, cross-referencing
* Search-driven UI

--end--

## Technical features (UI)

* search-driven navigation
  * tabs (heirarchical facets)
  * custom facets
  * indexing embedded content (via node refs)
  * search this section (menu item)
  * performance
* UI: all data lives in logical tree hierarchy
  * think 10k primary link items LOGICALLY, but really the tree is defined by biz logic
  * menus (custom code, core, menu_block)
  * breadcrumbs, context, flattening

--end--

## Technical features (Data)

* including revision, site has 70k nodes, imported from banner+documentum
* 15 content types, 170 field instances
* a lot of cross-linking via node references
* kind-of i18n (hacks for continuing studies)
* web services
* input filters (auto-detection of course names in any HTML content)

--end--

## Extra requirements

* Custom modules
  * Legacy => really really custom (4+ years of code drift)
  * Extended apachesolr 6.x-2.x-dev
* Contrib Modules
  * Had to deduce which version of contrib modules were enabled from system table
  * Many contrib modules were enabled but unused
* Concern about data and configuration integrity
* Test driven development
* Deliverable = upgrade script, not code + db dump

--end--

## Incidental challenges

* Defeaturization
* Deploying a dev site (not the same as prod?)
  * missing content types, modules, blocks
* content migrate running time
  * prune the database (10% of the nodes, focused on 1 faculty, try to keep consistency)
  * content_migrate_tweaks https://github.com/dergachev/content_migrate_tweaks
* git branch hecticness
* i18n_field allowed_values translation bug
* misc migration bugs (entityreference, nodeblock)

--end--

## Technical solutions

* Refactoring first for sanity
* Docker for build process
* Unit tests for the new code we write; phpunit for filters and menus
* Sitediff for correctness
* Content migrate tweaks for speed
* Search API FTW!

--end--

## Unit testing

* phpunit tests per module (works with D7 "OK")
 * bootstrap drupal => can't mock global functions, need process isolation
 * instead, use fixtures and mocks in your tests w/o drupal process isolation, can't mock global functions 
* autoloading: explored composer, manually, PSR0
* fixtures are awesome: menus, nodes

--end--

## Scripted upgrade process


* D6 deploy script
* d6 refactor adjustments
* d6 prepare (defeaturize, turn off non-core modules, change theme to bartik, pm-uninstall several modules)
* core updb
* enable modules, run contrib updb
* content migrate
* [menu\_adjustments.php](https://github.com/evolvingweb/coursecal-d7/blob/d7/build/upgrade/menu_adjustments.php)
* [d7\_adjustments.sh](https://github.com/evolvingweb/coursecal-d7/blob/d7/build/scripts/d7_adjustments.sh)
* [d7\_adjustments\_solr.sh](https://github.com/evolvingweb/coursecal-d7/blob/d7/build/scripts/d7_adjustments_solr.sh)
* all glued together by Makefile and multiple Dockerfile-s

--end--

## Docker for build process

* instantly spin-up of container (lightweight VM) with EXACT dev environment
* easily script build of container
* smart caching FTW!
* sipmlicity (vs chef): just know bash
* copy on write - instant snapshots
* [https://github.com/amirkdv/drupal-docker](https://github.com/amirkdv/drupal-docker)
* Makefile

--end--

## Docker tutorial / demo

* [https://github.com/dergachev/drupal-docker-marriage/](https://github.com/dergachev/drupal-docker-marriage/)

--end--

## SiteDiff

* bookmarklet
* show pretty diffs of HTML contents of whole sites
* sanitization - easy to write! easy to maintain!

--end--

## SiteDiff Input

        paths:
         - /
         - /user
         
        selector: 'body'
           
        sanitization:
        - title: 'remove form build id'
          pattern:    '<input type="hidden" name="form_build_id" value="form-[a-zA-Z0-9_-]+" *\/?>'
          substitute: '<input type="hidden" name="form_build_id" value="__form_build_id__">'
            
        before:
          dom_transform:
          - type: remove
            selector: '#something'

--end--

## SiteDiff output


![](https://dl.dropbox.com/u/29440342/screenshots/OTEHKZLG-2014.04.10-13-08-53.png)
![](https://dl.dropbox.com/u/29440342/screenshots/TZWTBTFV-2014.04.10-13-26-25.png)

--end--

## Content migrate tweaks
 
* [https://github.com/dergachev/content\_migrate\_tweaks](/https://github.com/dergachev/content_migrate_tweaks/)
* content\_migrate submodule of CCK is sloooow
* one field at a time, one node at a time, one value at a time
* stopped it after about 10 hours
* query optimization
* unit and integration testing

--end--

## Any questions about...?

* D7 Upgrades
* Content migrate
* Unit testing
* Docker
* Sitediff

--end-- 
