class QueueItem
  include Mongoid::Document
  field :message, type:String
  field :signature, type:Integer
end