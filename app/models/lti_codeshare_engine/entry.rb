require 'fiddle_fart'
require 'uuid'

module LtiCodeshareEngine
  class Entry < ActiveRecord::Base
    before_save :assign_uuid

    def self.new_from_url(url)
      begin
        obj = FiddleFart::Parser.parse(url)
        entry = self.new
        entry.klass = obj.class.name
        entry.remote_id = obj.try(:id)
        entry.revision = obj.try(:revision)
        entry.username = obj.try(:username)
        entry
      rescue => ex
      end
    end

    def edit_link
      driver.edit_link
    end

    def share_link
      driver.share_link
    end

    def embed_url
      driver.embed_url
    end

    def driver
      @driver ||= klass.constantize.new({
        id: remote_id,
        revision: revision,
        username: username
      })
    end

    private

    def assign_uuid
      if self.uuid.nil?
        uuid_generator = UUID.new
        self.uuid = uuid_generator.generate
      end
    end
  end
end
