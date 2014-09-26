class MessageToBrowser
  include Mongoid::Document
  field :message,   type:String
  field :signature, type:Integer

  class << self
    def send_items_to signature
      Item.where( signature:signature ).each do |item|
        puts "#{ self }.#{ __method__ } #{ signature }"

        message = { item:{ name:item[ :name ]}}.to_json
        MessageToBrowser.create( message:message     ,
                                 signature:signature )
      end
    end
  end
end