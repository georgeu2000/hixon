class MessageToBrowser
  include Mongoid::Document
  belongs_to :item

  class << self
    def send_items_to signature
      Item.where( signature:signature ).each do |item|
        puts "#{ self }.#{ __method__ } #{ signature }"

        MessageToBrowser.create( item:item )
      end
    end
  end
end