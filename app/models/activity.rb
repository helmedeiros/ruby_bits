class Activity < ActiveRecord::Base
  KINDS = %w[code choice].freeze

  belongs_to :lesson

  validates :title, :kind, presence: true
  validates :kind, inclusion: { in: KINDS }

  serialize :choices, Hash

  def code?;   kind == 'code';   end
  def choice?; kind == 'choice'; end
end
