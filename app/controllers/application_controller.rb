class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_action :python_connections

  private
  def python_connections
    @python_conn = Microservices::Python::Connections.new.conn
  end
end
