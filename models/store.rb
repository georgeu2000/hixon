class Store
  include Mongoid::Document
  field :name, type: String

  class << self
    def message
      puts 'message!'

      create( name:'first object!' )
      ap Store.all
    end
  end
end