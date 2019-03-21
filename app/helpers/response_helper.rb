module ResponseHelper
  PARAMETERS_ERROR = { error: 'missing parameters', err_code: 1400 }
  UNAUTHORIZED_ACCESS = { error: "not authorized", err_code: 1401 }
  FORBIDDEN_ERROR = { error: 'forbidden', err_code: 1403 }
  NOT_FOUND = { error: 'Not Found', err_code: 1404 }
  INTERNAL_ERROR = { error: 'internal server error', err_code: 1500 }
  FORBIDDEN_ACCESS = { error: "forbidden", err_code: 1403 }
  SUCCESS_OK = { success: true }

  def render_invalid(errors, err_code: nil)
    err_code = err_code || 1400
    response_body = { errors: error_messages(errors), err_code: err_code }
    render_error(400, response_body)
  end

  def render_model_error(errors)
    render_error(422, { errors: error_messages(errors), err_code: 1407})
  end

  def render_error(status, body)
    render json: Oj.dump(body, mode: :compat), status: status
  end

  def render_not_found
    render_error(:not_found, NOT_FOUND)
  end

  def render_forbidden
    render_error(:forbidden, FORBIDDEN_ERROR)
  end

  def render_unauthorized
    render_error(:unauthorized, UNAUTHORIZED_ACCESS)
  end

  def render_json(content, status = 200)
    render json: Oj.dump(content, mode: :compat), status: status
  end

  def render_created(content, status = 201)
    render_json(content, status = status)
  end

  def error_messages(errors)
    case errors
    when Array
      errors.reject{|i| i.empty? }.join(" ")
    when ActiveModel::Errors
      errors.messages
    else
      errors
    end
  end
end