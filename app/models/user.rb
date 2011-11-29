class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email valid")
    end
  end
end

class User < ActiveRecord::Base
  validates :name, :email, :password, :presence => true
  validates :password, :length => {:minimum => 4}
  validates :email, :uniqueness => true
  validates :email, :email => true
  
  has_many :posts, :dependent => :destroy
end
