class QueueItem
  include Mongoid::Document
  field :message, type:String
end