class ApplicationController < ActionController::Base
  def render_flash
    render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash")
  end
end
