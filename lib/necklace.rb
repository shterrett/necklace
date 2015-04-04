module Necklace
  def through(enumerable, methods)
    methods.reduce(enumerable) do |result, method|
      send(method, result)
    end
  end
end
