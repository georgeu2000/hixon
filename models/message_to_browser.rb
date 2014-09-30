class MessageToBrowser
  include Mongoid::Document
  field :model,     type:String
  field :target_id, type:String
  

  class << self
    def send_objects_to signature, model
      klass = Utils.class_for( model )

      klass.where( signature:signature ).each do |target|
        puts "#{ self }.#{ __method__ } #{ signature }"

        MessageToBrowser.create( model:model, target_id:target.id )
      end
    end
  end

  def object
    klass = Utils.class_for( model )
    klass.where( _id:target_id ).first
  end
end