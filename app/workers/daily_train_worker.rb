require 'sidekiq-scheduler'

class DailyTrainWorker
  include Sidekiq::Worker

  def perform
    python_connections
    Train::Daily.new.daily(@python_conn)
    Train::Weekly.new.weekly(@python_conn)
    Train::Monthly.new.monthly(@python_conn)
    Train::Yearly.new.yearly(@python_conn)
  end

  private

  def python_connections
    @python_conn = Microservices::Python::Connections.new.conn
  end
end
