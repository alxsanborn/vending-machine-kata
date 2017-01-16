require_relative 'concerns/actions.rb'

class InsertedCoin < ApplicationRecord
  belongs_to :order

  include Actions::InsertedCoin

  @@machine_quarters = 0
  @@machine_dimes = 0
  @@machine_nickels = 0

  def self.machine_quarters=(machine_quarters)
    @@machine_quarters = machine_quarters
  end

  def self.machine_quarters
    @@machine_quarters
  end

  def self.machine_dimes=(machine_dimes)
    @@machine_dimes = machine_dimes
  end

  def self.machine_dimes
    @@machine_dimes
  end

  def self.machine_nickels=(machine_nickels)
    @@machine_nickels = machine_nickels
  end

  def self.machine_nickels
    @@machine_nickels
  end

end
