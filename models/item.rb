class Item
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :signature, type:Integer
  field :cid,       type:String
  
end