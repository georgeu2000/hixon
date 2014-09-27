class Item
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :signature, type:Integer
  field :cid,       type:String
  has_one :message_to_browser
  
end