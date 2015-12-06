class Poll < ActiveRecord::Base
  belongs_to :house
  has_many :vote_options, dependent: :destroy
  validates :topic, presence: true
  accepts_nested_attributes_for :vote_options, :reject_if => :all_blank, :allow_destroy => true

  def normalized_votes_for(option)
    votes_summary == 0 ? 0 : (option.votes.count.to_f / votes_summary) * 100
  end

  def votes_summary
    vote_options.inject(0) {|summary, option| summary + option.votes.count}
  end

  def top_voted
    max = 0
    top_voted = nil
    self.vote_options.each do |v|
      if v.votes.count > max
        max = v.votes.count
        top_voted = v
      end
    end
    puts "max: " + max.to_s
    return top_voted
  end
end
