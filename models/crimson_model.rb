class CrimsonModel
  include Mongoid::Document
  field :signature, type:Integer
  field :cid,       type:String

  after_save :send_update
  
  def send_update
    MessageToBrowser.create( model:self.class.to_s, target_id:id )
  end
end