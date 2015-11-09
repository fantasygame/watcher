module ToSee
  class Result
    attr_accessor :result_hash

    def initialize(result_hash)
      @result_hash = result_hash
    end

    def tvs
      tvs = []
      @result_hash.each do |tv, result|
        tvs << ToSee::Tv.new(tv, result)
      end
      tvs
    end

    def empty?
      @result_hash.empty?
    end
  end
end
