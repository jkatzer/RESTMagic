Overview.
-----

RESTmagic is a framework for that framework you already deployed, your RESTFUL api. Light or no configuration will tell the framework how your resources are organized, and where to get the appropriate templates. Before it joins those together with your choice of mustache flavored templating, it will check if you have a native view instead to present. The whole framework is built to be easily customized with as much or as little magic as your want.

Example App
-----
Working on the docs but there is an example app that hooks up to the twitter api. Try extening it by adding more html templates to the templates directory

1. cd TwitterExample
1. pod install
1. open TwitterExample.xcworkspace
1. Build and Run!


Usage
-----
Add me to your podfile and then modify the RESTMagic sample plist and add it to your project this is where the settings come from.


More to Come
-----
If you are interested in this at all just email hey {at} restmagic {dot} org or jkatzer on github and i'll help you out.

Branches
-----
master - tested code that is official and the basis of releases. features tags will be in here. cocoapods will come from here.

feature-anythingelse - anything that is not in master is subject to change and crashes.


Versions
---------
Here are the future plans

0.0.2 - Released!!!: A lot of cool stuff. (easy automatic subclass of RMViewController which i am using to easily have an ECSlidingViewController) and way more. Loads remote templates. If an api response is HTML, it will be presented in lieu of a template. Also there is now an authentication modal view controller that can be presented when the user needs to login. after login reloads the view underneath, or if they hit cancel, pops off the view that requested login.

0.0.3 - Work in progress that will be release March

0.0.4 - Work in progress that will be release April (feature lock for 0.1)

0.1 - Proper downloading and caching of templates - (Adding AFNetworking)

0.2 - Clean Ways to override methods and more settings in the plist

0.3 - Update ExampleApp to use a cleaner MVC structure. Add additional examples

0.4 - More Magic

0.5 - Feature freeze for v1.0

1.0 - YOU!!!!!!
