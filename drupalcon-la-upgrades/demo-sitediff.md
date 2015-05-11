* Demo of getting started with sitediff
* Repo: https://github.com/vasi/sitediff-update-demo-deploy

**Show website**

* Again, we already have a docker image. Just ```make run```
* Click around site at http://docker2:9180

**Show off sitediff**

* _Go to local terminal for sitediff! We don't want to mess around with Vagrant_
* Run ```sitediff init http://docker2:9180```
* It crawls the site up to a certain depth, and creates some files
* Show ```ls sitediff```: There's a configuration file ```sitediff.yaml```, and a cache file ```cache.db.db```

**Show an initial diff**

* Run ```sitediff diff```. This compares the site to itself. We made no changes, so we expect to see no changes.
* But we see changes after all! Indicate form build IDs in ```/user/register``` path.
* Show ```sitediff.yaml```: Point out sanitization rule to make form build IDs look the same, and that the rule is disabled.
* Enable the rule, and run diff again: ```sitediff diff --paths /user/register```. Now the form build ID diff is gone.
* We wrote a bunch of rules for common Drupal issues. Sitediff detects that they're likely to be necessary, so it puts them in the config file. You can write your own rules too!
* Enable all the built-in rules with ```sitediff init --rules=yes http://docker2:9180```
* Now ```sitediff diff``` is clean!

**Add some content**

* Create an article. Note that it's on the front page
* Run ```sitediff diff```. It finds the change!
 * There's an RSS feed
 * The 'first-time' div is gone
 * Our article is there
* These are all changes we're happy with, so tell sitediff to update the cache: ```sitediff store```

**Explain the Drupal 7.36 bug**

* Show the version of Drupal that we're on, with ```drush ups```. It's 7.35.
* There's a known bug in Drupal 7.36 that sometimes disables content types: https://www.drupal.org/node/2465159
* Some people may have had the bug, but never noticed
* But sitediff can detect it!

**Use sitediff to find the bug**

* Let's update to Drupal 7.36
* ```make ssh```
* ```drush up -y drupal-7.36```
* _If no network access, then git co update and updb_
* Now visit the homepage: It looks the same
* But do a ```sitediff diff```, and the bug shows up!

**Web UI**

* It's hard to read all the output, so do ```sitediff serve```
* Show side-by-side view of ```/node/add/page```, point out differences
* The left side is served from our cache! That page no longer exists in Drupal
* Show HTML diff view, too
* sitediff is awesome!

**If too much time remains**

* Dual-site mode
* Sanitization rules
...
