class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
end
