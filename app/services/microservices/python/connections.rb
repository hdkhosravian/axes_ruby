class Microservices::Python::Connections
  attr_accessor :conn
  
  def initialize
    @conn = Faraday.new(
      url: ENV["PYTHON_SERVER"],
      headers: {'Content-Type' => 'application/json'}
    )
  end
end