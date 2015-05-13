* Demo of docker, behat, and CircleCI
* Repo: https://github.com/evolvingweb/drupal-docker-marriage

**Show website**

* We already built a docker image for this site
  * This site is a simple example of how to Dockerize a Drupal site, see the README
* ```make run``` runs the image we have, with some port mapping
* Visit http://docker2:8080
* There's a navigation menu, with active links
* There's an RSVP form, which shows "Thank you" on submit

**Show tests**

* behat.yml contains some boilerplate, explain it a bit
* It contains a region, too, which is a CSS selector that goes to the active menu
* site/tests/features/test.feature contains the actual tests of the above features, go through it.

**Run tests**

* Use ```docker exec -ti marriage bash```
* Run ```behat``` to run the tests

**Try an upgrade**

* ```cd /var/www```
* Run ```drush ups``` to show some available module upgrades
* Let's try upgrading webform! ```drush up -y webform```
* Then re-run the tests with ```behat```
* They all succeed, great!

**Try a broken upgrade**

* Run ```drush up -y bootstrap```
* Re-run the tests, notice one failed!
* Visit the site, notice the nav menu is mussed up
* Do ```docker destroy run``` and show that we reverted! No harm in trying updates, even if they don't work.

**Demo CircleCI**

* We turned each of these changes into a Pull Request on GitHub: https://github.com/evolvingweb/drupal-docker-marriage/pulls
* Note the little status messages: checks or exes
* These were created by CircleCI!

**CircleCI output**

* Show the CirleCI details for the failure
* Click 'circle.yml', explain a bit
* Show some of the ```make build``` log. Note some sections, to illustrate how the Dockerfile was run, eg:
 * apt-get install
 * drush updb
* Show the test error that was found.
 
