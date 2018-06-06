# == Schema Information
#
# Table name: emojis
#
#  id           :bigint(8)        not null, primary key
#  kind         :integer
#  position     :jsonb
#  reading_id   :bigint(8)
#  subject_type :string
#  subject_id   :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Emoji < ApplicationRecord
  belongs_to :reading
  belongs_to :subject

  enum kind: {
    admire: 0,
    cute: 1,
    dubious: 2,
    lack_understanding: 3,
    laugh: 4,
    love: 5
  }

end
