# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl <ApplicationRecord
  validates :long_url, :user_id, presence: true

  def self.shorten_url(user, long_url)
    ShortenedUrl.create!(short_url: ShortenedUrl.random_code, user_id: user.id, long_url: long_url)
  end

  def self.random_code
    shortened = nil
    until !ShortenedUrl.exists?(shortened) && !shortened.nil?
      shortened = SecureRandom.urlsafe_base64
    end
    shortened
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors, through :visits, source :user

  def num_clicks
    Visit.all.select { |visit| visit.shortened_url_id == self.id }.count
  end

  def num_uniques
    Visit.all.select { |visit| visit.shortened_url_id == self.id }.distinct.count
  end

  


end
