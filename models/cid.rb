class Cid
  CID_LENGTH = 20

  class << self
    def generate
      rand( 36**CID_LENGTH ).to_s( 36 )
    end
  end
end