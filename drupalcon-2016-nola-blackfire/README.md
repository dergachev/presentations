<div style="position: absolute; height: 97%; width: 100%;">
  <h2 style="margin:30px auto 50px 0px; font-size:1.8em; font-weight:bold; width: 90%; text-align: center">
    Using Blackfire.io to profile Drupal loading time
  </h2>
  <table style="width: 90%"><tr>
    <td style="font-size:0.7em; text-align: center; width:50%;">
      <div style="font-size:1.2em; font-weight:bold;">Alex Dergachev</div>
      <div> alex@evolvingweb.ca </div>
      <div> @dergachev on twitter, github, drupal.org </div>
    </td>
    <td style="font-size:0.7em; text-align: center; width:50%;">
      <div style="font-size:1.2em; font-weight:bold;">Dave Vasilevsky</div>
      <div> vasi@evolvingweb.ca </div>
      <div> twitter.com/djvasi </div>
      <div> @vasi on github, drupal.org </div>
    </td>
  </tr></table>

  <p><img src="img/ew-good.png" style="height:130px; margin: 10px 0 0 0; position: absolute; bottom: 0;"></p>
</div>

--end--

## About Evolving Web

* Drupal development, consulting and training since 2007
* Very involved with the Drupal community
* Specialties
  * Infrastructure
  * Multilingual content 
  * Solr search UI
  * Content migration
  * Design and responsive themes
  * Module dev: custom applications built on Drupal
  * Expert Drupal training
* Based in Montreal, clients in Canada and USA

--end--

![](img/ew-projects.png)

--end--

## Drupal training program

<img src="img/suzanne-presenting.jpg" width="25%" style="float: right; margin-left: 40px; margin-right: 20px" />

* Public: Montreal, Ottawa, Toronto, DC Munich, NJ, NYC, Boston, Chiacgo
* Private: Health Canada, Parks Canada, Tourism Quebec, Trent U, McGill U, remote
* Enterprise teams, dev shops, remote

--end--

## About the speakers

* Alex co-founded Evolving Web straight out of undergrad
* Dave was there to show us version control and Linux
* Besides doing Drupal projects since 2008...

--end--

## Outline

* Intro + motivation
* Profiling methodology + philosophy
* Demo 1: Blackfire UI Tour
* Blackfire basics: Terminology, advantages, installation
* Blackfire features (basic + intermediate)
* Demo 2: Copy as cURL
* Blackfire + Drupal tricks
* Demo 3: Block visibility
* Drupal performance considerations
* Q & A

--end--

## Motivation

Why are we all here?

--end--

## Why page loading time is SUPER IMPORTANT

* User experience
* Concurrency + scalability
  * "Throw more hardware at it"
* Financial implications
* Google

--end--

## What profiling doesn't measure

* Front-end / browser rendering time
  * JS
  * CSS / images
* Network issues

--end--

## What profiling measures

<img src="img/druplicon-xray.jpg" width="25%" style="float: right; margin-left: 40px; margin-right: 20px" />

* page generation time, CPU + memory info
* blocking operations: SQL + external requests
* what part of your PHP code is slowing things down

--end--

## Why it's important

* Drupal core is not exactly lightweight, contrib varies, custom + legacy code
* We deal with many projects, working on slow ones makes us sad
  * Example scenario of Drupal slowness

--end--

## Profiling gets results, fast

1. McGill Course Calendar
  * 260ms -> 225ms, 13%
  * took 1h to locate and fix a problem involve node\_load
1. D8 evolvingweb.ca site
  * block visibility (80ms out of 450ms, 18%)
  * metatag module patch (saves 30ms)
  * took 2 hours to identify problems, + 2 days to fix
1. Linux Foundation: device certification workflow
  * Views over revisions; used xdebug + code study
  * Took 3 hours to diagnose + add revision cache
  * 980ms -> 420ms
1. Client X
  * slow redirect (390ms -> 95ms), took an hour to diagnose and fix
  * buggy version references\_dialog; 1s to 770ms (23%); 30m to diagnose + fix
  * uncached megamenu: 770ms to 480ms, took 2 hours to diagnose, several hours to fix
  * helped figure out an unfamiliar codebase

--end--

## Profiling Methodology

Let's discuss what we're setting out to do.

--end--

## Define what is "fast enough"

* Identify performance goals: what does it mean to be fast?
* VS other sites
* VS user expectations
* Isolate front-end from back-end
* Understand cached vs uncached behavior
  * why varnish isn't enough

--end--

## How to profile

* Define behavior externally (path, logged in, environment, isolation, caching...)
* Use a profiler to analyze internal behavior
  * Figure out what the code is doing
* Look for any low hanging fruit, bottlenecks
  * (easily cachable requests, bad SQL, blocking requests, unecessary entity loads, watchdog,...)
* Look for signs of overall sluggishness (eg swapping, hard-drive contention, network issues, slow/shared server, lack of APC)
* Build a hypothesis on the bottleneck
* Document the scenario, mark it as a reference (baseline)
* Make a change, do a comparison
  * In drupal, static caching means removing "slow" code just pushes it to later in request
* Iteration
  * Log your runs, later it will be hard to remember all you've changed
* Know when to stop profiling
* Divide and conquer / compare variations
  * variations: pages, site, server env, enable/disable modules, comment out code

--end--

## Measurement tools

* Front-end: Chrome dev tools
  * YSlow, GTMetrix, WebPageTest.org, Google PageSpeed
* Benchmark: ab (Apache bench), jmeter, siege
* Application Performance Monitoring: newrelic
* PHP Profiling: xhprof / blackfire

--end--

## Introducing blackfire PHP profiler

* free for basic use case
* easy to install
* intuitive GUI and process (comparisions, collaboration)
* gets does the job

--end--

## Case study: Coursecal

* Live demo....

--end--

## Understanding Blackfire.io

About how it works...

--end--

## Understanding Blackfire.io

* By Sensio Labs, creators of Symphony
* Started as a fork of xhprof...
  * SAAS, easier to manage (but perhaps data risk)
  * Interactive callgraph, better user experience
  * Better UX Supports comparisons
  * Actively maintained, support for PHP 7
  * Great docs, simpler installation
    * packages (docker / chef / ansible), embedded (magento cloud, heroku, platform.sh)

--end--

## Installing Blackfire

Components:

* probe, a minimalistic PHP extension
* blackfire-agent, a daemon that connects probe to blackfire servers
* Companion, a Chrome extension
* blackfire command-line client

--end--

## Installing Blackfire

View [Blackfire Install Docs](https://blackfire.io/docs/24-days/06-installation), which has your API keys, and also instructions for RedHat, OSX, Windows, docker, chef, and more. Install steps on ubuntu:

          wget -O - https://packagecloud.io/gpg.key | sudo apt-key add -
          echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list
          sudo apt-get update
          sudo apt-get install blackfire-agent blackfire-php
          # fill in server-id and server-token
          sudo blackfire-agent --register
          sudo /etc/init.d/blackfire-agent start

          # for command-line use, fill in client-id and client-token
          blackfire config

          # disable xhprof and xdebug php extensions
          # restart apache or php-fpm
--end--

## Blackfire features

* Comparison with baseline profile
* Copy as curl (for ajax, cookies, POST requests)
* profiling command-line / drush commands
  * drush.launcher
* Sharing profiles publicly
* Use blackfire to learn new codebase (or contrib modules)

--end--

## Case study: Client X

* Explain problem: slow homepage
* Chrome network tab: redirect!
* Copy as cURL!
* Run profile
* It's theming before redirect!?
* Search for drupal\_goto to find problematic function
* Replace with hook\_init
* This helped us learn new codebase
	* Logic in with theme code
	* Custom language detection
* When you find one issue, you might find more!
	* All users have cookie, this explains bad caching

--end--

## Advanced Blackfire features

* Aggregation (10 requests, averaged)
  * Turn aggregation to control for caching and side effects
* Blackfire doesn't keep arguments (or 1 at most)
* Sampling, not tracing!
* Blackfire PHP SDK

--end--

## Other considerations

* xdebug conflict
* profiling overhead (PHP 7)
* Tradeoff: memory vs time
* Caching and dirty runs
  * D7 + D8 cache killing

--end--

## Diagnostic tricks

* References / comparison
* xdebug + read the code
* Argument capturing
* SDK: enableProbe / disableProbe

--end--

## Case study: D8 evolvingweb.ca

* Problem: Slow page
* Caching issues
	* Only when not in page\_cache, dynamic\_page\_cache
	* This is a problem with aggregation!
	* Cache invalidation of just one node (CODE)
* Profile
	* Find slow function
* Diagnosis: block visibility
	* Loads all the blocks to check access
	* Complex condition checking, metadata merging
* Explain the fix
	* Like node access, one big query
	* Module: [block\_access\_records](https://github.com/vasi/block_access_records)
* Show comparison profile

--end--

## Premiume Blackfire features

* Environments
  * Groups of profiles and team members
  * One for dev / stage / prod, per project
* Longer data retention
* CI + scenarios + notifications
  * trigger via web service
  * slack integration
* Assertions
* Custom metrics
* Recommendations
* Self-hosted version
* Talk to the guys in the Blackfire booth!

--end--

## Generic Drupal Backend Tips

* Use these: varnish/memcache/APCu/Opcache
  * But memcache only helps speed up cache\_set/ cache\_get and overall load on DB
* D8 render cache with tags + context
* D7 vs D8 (complexity Vs caching)
* Control number of contrib modules
  * Do less stuff, or write it custom 
* Mysql tuning http://www.jeffgeerling.com/articles/web-design/2010/drupal-performance-white-paper
* Cron job, search, watchdog, SSD, multiple app heads, CDN, php7, fpm, nginx for files
* cookies + page cache
* devel web profiler
* entity\_load\_multiple()
 * devel module's sql query log

--end--

## Following Up

* Please fill in the [feedback form](https://events.drupal.org/neworleans2016/sessions/using-blackfireio-profile-your-loading-time) for this session!
* Join us for Code Sprints
  * Friday, May 13 at the Convention Center
  * First-Time Sprinter Workshop - 9am-12pm in Room 271-273
  * Mentored Core Sprint - 9am-6pm in Room 275-277
  * General Sprints - 9am-6pm in Room 278-282
* Evolving Web: [evolvingweb.ca](http://evolvingweb.ca)
* Follow @dergachev and @djvasi on twitter
  * write us for help
* block\_access\_records: [github.com/vasi/block\_access\_records](https://github.com/vasi/block_access_records)
* Go to Blackfire booth
  * Blackfire.io coupon - DRUPALNOLA2016
  * Pick up "24 days of Blackfire", a great short book to read on the plane ride back!
