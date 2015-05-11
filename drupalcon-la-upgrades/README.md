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
      <div> evolvingweb on d.o. </div>
    </td>
    <td style="font-size:0.7em; text-align: center; width:50%;">
      <div style="font-size:1.2em; font-weight:bold;">Dave Vasilevsky</div>
      <div> vasi@evolvingweb.ca </div>
      <div> github.com/vasi </div>
      <div> twitter.com/djvasi </div>
      <div> evolvingweb-vasi on d.o. </div>
    </td>
  </tr></table>

  <p><img src="resources/img/ew-good.png" style="height:130px; margin: 10px 0 0 0; position: absolute; bottom: 0;"></p>
</div>

--end--

## Outline

* About us (3m)
* Intro (9m)
  * Testing
  * Minor Updates
  * Major Core Upgrades
* Case study: McGill Academic Calendar to D7 Upgrade (15m)
  * Project description
  * Challenges
  * Tools: Docker, phpunit, SiteDiff
	* Solutions
* Other tools	(4m)
  * behat
	* CircleCI
* Demo of drupal-docker-marriage (8m)
* Even more tools (4m)
  * git
	* backups
	* upgrade path tests
* Demo of SiteDiff (8m)

--end--

## About Us

* Alex co-founded Evolving Web straight out of McGill, 2007
* Dave was there to teach us SVN

* tool that automates the creation and running of VMs for dev and prod
* not a webservice, but a tool that runs on your machine

--end--

## What is Docker?

* tool that automates the creation and running of VMs for dev and prod
* not a webservice, but a tool that runs on your machine

--end--

## How Docker works?

* VMs vs containers: light-weight, shared resources and kernel
* need to run on Linux, or in a Virtualbox VM
* Dockerfile: start from generic "ubuntu:14.04" container, convert to your drupal project
* Definition: image vs container

--end--

## Advantages of Docker

* spin up dev env quickly, great for onboarding 
* consistency (all dependencies are the same for all team members)
* easier to replicate bugs
* opportunity for CI (circle CI)
* build process: Dockerfile
* caching
* includes C libraries (yaml), and also tomcat, solr, memcache, APC, xhprof, xdebug, etc ...
* everyone and and their dog is considering it
* easily share images

--end--


## Caveats

* we haven't made it industrial-grade yet
* lots of best practices to figure out, but the costs are up-front
* manual adaptation to new site

--end--

## Docker commands

* docker build -t marriage .
* docker run -it marriage /bin/bash
* docker run marriage start.sh
* docker run -p 8080:80 marriage start.sh
* docker run -v /home/alex/source:/drupal marriage start.sh

--end--

## Docker tutorial / demo

* [https://github.com/dergachev/drupal-docker-marriage/](https://github.com/dergachev/drupal-docker-marriage/)

--end--

## Docker for build process

* instantly spin-up of container (lightweight VM) with EXACT dev environment
* easily script build of container
* smart caching FTW!
* sipmlicity (vs chef): just know bash
* copy on write - instant snapshots
* Makefile

--end--


## How we used Docker

* deployment in separate repo - see [README.md](https://github.com/evolvingweb/allseen-deploy)
* deploy.sh
* Dockerfile
* Makefile

--end--

## SiteDiff

* [github.com/dergachev/sitediff](https://github.com/dergachev/sitediff)
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


## Case study 1: D7 upgrade

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

## About the project

* Linux Foundation Collaborative Project
* Existing D7 site
* Goal is to use Markdown + git workflow, custom nodejs static site generator, import into Drupal
* Use migrate module to import: nodes, files, menu_links
* UI challenges: building a responsive menu with depth up to 7 levels

--end--

## Migrate strengths

* analysis/verification of field mappings
* hash-based incremental updates 
* existing sources: files, JSON, csv, d2d, sql...
* existing destinations: node, menu_link, user, file, entity
* extensible via OO
* drush ui
* rollback and undo

--end--

## Migrate weaknesses

* crufty code base
* some sources are limited (no recursive sources, eg for menus or books)
* incremental updates don't track deletions
* error handling: eg. crashes if source content missing

--end--

## Our improvements

* NavSource for recursive yaml parsing, uses RecursiveIteratorIterator
* git workflow integration (status, diff, rollback)
* dry run
* lots of validation of content (eg broken links in HTML, broken references, invalid HTML)
* deletion on incremental updates
* html parsing with query path in prepareRow()

--end--


## Content migrate tweaks
 
* [https://github.com/dergachev/content\_migrate\_tweaks](/https://github.com/dergachev/content_migrate_tweaks/)
* content\_migrate submodule of CCK is sloooow
* one field at a time, one node at a time, one value at a time
* stopped it after about 10 hours
* query optimization
* unit and integration testing

--end--

## SiteDiff demo

![](img/sitediff-screenshot.png)

## Any questions about...?

* Docker
* Sitediff
* D7 Upgrades
* Content migrate
* Unit testing
* Migrate

--end-- 
