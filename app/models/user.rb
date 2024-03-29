class User < ActiveRecord::Base
  has_secure_password

  attr_accessor :profile_redir_from

  has_one :profile, dependent: :destroy
  has_one :visit_counter, dependent: :destroy

  has_many :sponsored, :class_name => "User",
    :foreign_key => "sponsor_id"
  belongs_to :sponsor, :class_name => "User"

  validates_uniqueness_of :email1
  validates :nick, :subdomain, presence: true


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.member subdomain
    User.where(subdomain:subdomain).first || User.find(1)
  rescue
    raise "There is no user"
  end


end
