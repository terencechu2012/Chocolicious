class Budget < ActiveRecord::Base
  has_attached_file :poster
  has_many :budget_expenses, dependent: :destroy
  has_many :budget_incomes, dependent: :destroy
end
