# == Schema Information
#
# Table name: draws
#
#  id                 :bigint(8)        not null, primary key
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  chapter_id         :bigint(8)
#  reading_id         :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Draw < ApplicationRecord
  belongs_to :chapter
  belongs_to :reading
end
