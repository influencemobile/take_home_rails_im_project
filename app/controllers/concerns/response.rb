# app/controllers/concerns/response.rb
module Response 
  def json_response(object, status= :ok)
    logger.info '[Response][json_response]'
    render json: object, status: status
  end
end