# Include hook code here
ActiveRecord::Validations::ClassMethods.send :include, Elfproef
ActiveRecord::Base.class_eval do
  include ActiveRecord::Validations
end