class Club < ActiveRecord::Base
  has_many :expenditure_accounts, :dependent => :delete_all
  has_many :requests, :dependent => :delete_all
  has_many :reserve_accounts, :dependent => :delete_all
  has_many :clubusers, :dependent => :delete_all
  has_many :claims, :dependent => :delete_all
  
end
