# == Schema Information
#
# Table name: readings
#
#  id         :bigint(8)        not null, primary key
#  finished   :boolean          default(FALSE)
#  user_id    :bigint(8)
#  chapter_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reading < ApplicationRecord
  require 'digest'

  belongs_to :user
  belongs_to :chapter
  has_many :draws, dependent: :destroy
  has_many :emojis, dependent: :destroy
  has_one :book, through: :chapter
  has_one :connection, -> (reading) { unscope(:where).where 'reading_id = :id or other_reading_id = :id', id: reading.id }, dependent: :destroy

  scope :current, -> { where(finished: false).limit(1).first }
  scope :for, -> (book) { find_by chapter_id: book.chapter_ids }

  def draw_for(chapter)
    draws.find_by chapter_id: chapter.id
  end

  def beggined?
    !chapter.position.zero?
  end

  def connect!
    (book.connections.pending.first || Connection.new).add(self).save
    self
  end

  def connected?
    connected_reading.present?
  end

  def connected_reading
    connection.other_reading_for self
  end

  def as_json(options = {})
    json = {
      id: id,
      chapter_id: chapter_id,
      finished: finished,
      book: book.as_json,
      user: user.as_json,
    }.tap do |json|
      if options[:recursive] != false
        json.merge!(
          chapters: book.chapters.as_json(reading: self),
          connected_reading: connected_reading&.as_json(recursive: false)
        )
      end
    end

    json[:hash] = Digest::MD5.hexdigest json.to_json if options[:recursive] != false

    json
  end
end
