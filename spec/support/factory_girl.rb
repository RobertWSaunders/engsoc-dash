# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md

# Why Factories instead of Fixtures?
#########################
# The default method of test objects within Rails is fixtures. 
# Fixtures files are in written the YAML format. 
# Providing a basic static mock object representation. 
# Fixtures will get tougher as the model objects get 
# more complex. Including their associations 
# proliferating. FactoryGirl describes itself as 
# an API to create test objects. Meaning, you will 
# programmatically use the API to create mock 
# objects for your tests. You can provide a factory 
# definition, in Ruby, then use the API much 
# like normal object to `.build` or `.create`. 
# FactoryGirl also makes it super simple to 
# include associations through the factory 
# definitions.

# Factories Best Practices
#########################
# It is highly recommended that you have one factory 
# for each class that provides the simplest set of 
# attributes necessary to create an instance of that 
# class. If you're creating ActiveRecord objects, 
# that means that you should only provide attributes 
# that are required through validations and that do 
# not have defaults. Other factories can be created 
# through inheritance to cover common scenarios for 
# each class.

# Defining Factories
#########################
# Attempting to define multiple factories with the 
# same name will raise an error.

# Factories can be defined anywhere, but will 
# be automatically loaded after calling 
# FactoryGirl.find_definitions (done automatically with Rails, I think...) 
# if factories are defined in files at the following locations:
#   test/factories.rb
#   spec/factories.rb
#   test/factories/*.rb
#   spec/factories/*.rb

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# For reference:
# RSpec without Rails
  # RSpec.configure do |config|
  #   config.include FactoryGirl::Syntax::Methods

  #   config.before(:suite) do
  #     FactoryGirl.find_definitions
  #   end
  # end

