class CrimsonModel
  include Mongoid::Document
  field :signature,  type:Integer
  field :cid,        type:String
  field :removed,    type:Boolean

  def self.create_for params
    puts "#{ self }##{ __method__ } #{ params }"

    view = params.delete( :view )

    cm = create( params )
    cm.send_update_to view

    cm
  end


  def update_for params
    view = params.delete( :view )

    update params
    send_update_to view

    self
  end


  def delete_for view
    self.removed = true
    save

    send_update_to view
  end

  
  def send_update_to view
    puts "#{ __method__ } #{ view }"
    MessageToBrowser.create( model:self.class.to_s, target_id:id, view:view )
  end
end
