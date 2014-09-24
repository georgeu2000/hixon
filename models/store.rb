class Store
  include Mongoid::Document
  field :name, type:String

  class << self
    def message
      create( name:'first object!' )
    end

    def send_message
      puts "#{ self } creating queue item..."
      QueueItem.create( message:'message from server')
    end
  end
end