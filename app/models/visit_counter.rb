class VisitCounter < ActiveRecord::Base
  belongs_to :user

  def inc
    self.count+=1
    self.save!
  end

  def self.total
    sum :count
  end

end
