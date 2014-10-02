class MessageToBrowser
  include Mongoid::Document
  field :model,     type:String
  field :target_id, type:String
  

  class << self
    def send_objects_to signature, model, filter
      klass = Utils.class_for( model )
      filter_hash = filter_hash_for( filter )

      klass.where( filter_hash ).each do |target|
        puts "#{ self }.#{ __method__ } #{ signature }"

        MessageToBrowser.create( model:model, target_id:target.id )
      end
    end

    def filter_hash_for filter
      return {} unless filter

      parts = filter.split( ':' )
      { parts[ 0 ] => parts[ 1 ]}
    end
  end

  def object
    klass = Utils.class_for( model )
    klass.where( _id:target_id ).first
  end
end