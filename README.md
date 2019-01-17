# cucap_setup
 Setting up web testing with Cucumber and Capybara 

Capybara with Cucumber on Non rails App with Chrome driver


Ref: https://testingbot.com/support/getting-started/cucumber.html

Ref: https://gist.github.com/abeger/2378414


1. ========Create Empty project=====
     rvm use ruby-2.5.3
2. ========Create Gemfile==========
	gem bundle init
	to create gem file
3. Here I am using chrome HDless driver setup

4. Create features dir
5. Create features/step_definitions dir
6. Create support dir
7. Create "env.rb" in "features/support"
8. 

User cmd to run on UI mode 
CHROME_HEADLESS=false cucumber features/smoke/home.feature

User cmd to run on HeadLess mode 
cucumber features/smoke/home.feature



