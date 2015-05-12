class Activity < ActiveRecord::Base
  KINDS = %w[code choice].freeze

  belongs_to :lesson

  validates :title, :kind, presence: true
  validates :kind, inclusion: { in: KINDS }
  validates :difficulty, inclusion: { in: 1..5 }

  serialize :choices, Hash
  serialize :hints,   Array

  def code?;   kind == 'code';   end
  def choice?; kind == 'choice'; end

  def difficulty_label
    %w[trivial easy medium hard nightmare][difficulty.to_i - 1]
  end
end
