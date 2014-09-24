class Store
  include Mongoid::Document
  field :signature, type:Integer

  class << self
    def message_for signature
      puts " #{ self }.#{ __method__ } creating for #{ signature }"
      Store.create( signature:signature )
    end

    def send_message
      puts "#{ self } creating queue item."

      signature = Store.first.signature if Store.first
      QueueItem.create( message:'message from server', 
                        signature:signature )
    end
  end
end