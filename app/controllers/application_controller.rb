class ApplicationController < ActionController::API

  def render_json(result)
    if result.success?
      render json: {data: result.data}, status: 200
    elsif result.failed?
      render json: {errors:result.errors}, status: 400
    end
  end
end
