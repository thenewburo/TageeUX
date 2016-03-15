class Service < ActiveRecord::Base

  belongs_to :user

  validates :user, presence: true
  validates :uid, presence: true

  class << self

    def find_or_create_by_authentication_hash(hash, user)
      user = User.includes(:services).
        where(services: { provider: hash[:provider], uid: hash[:uid] }).
        first_or_initialize(screen_name: (hash[:info][:nickname] || hash[:info][:name] || hash[:info][:username]),
                            avatar_url: hash[:info][:image])
      if user.new_record?
        service = user.services.build(provider: hash[:provider],
                                      uid: hash[:uid], auth_token:
                                      hash[:credentials][:token],
                                      auth_secret: hash[:credentials][:secret])
        user.save!
      else
        user.update_attributes avatar_url: hash[:info][:image], screen_name: hash[:info][:nickname]
        service = user.services.where(provider: hash[:provider], uid: hash[:uid]).first
        service.update! auth_token: hash[:credentials][:token], auth_secret: hash[:credentials][:secret]
      end

      service
    end

  end

end
