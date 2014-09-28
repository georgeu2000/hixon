class MessageToBrowser
  include Mongoid::Document
  field :model,     type:String
  field :target_id, type:String
  # belongs_to :item

  class << self
    def send_objects_to signature, model
      klass = Module.const_get( model.capitalize )

      klass.where( signature:signature ).each do |target|
        puts "#{ self }.#{ __method__ } #{ signature }"

        MessageToBrowser.create( model:model, target_id:target.id )
      end
    end
  end

  def object
    klass = Module.const_get( model.capitalize )
    klass.where( _id:target_id ).first
  end
end