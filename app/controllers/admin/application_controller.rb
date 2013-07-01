class Admin::ApplicationController < ApplicationController
  before_filter :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      @authenticated = username == Settings.authentication.username && password == Settings.authentication.password
    end
  end
end
