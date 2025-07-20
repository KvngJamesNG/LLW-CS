class ApplicationController < ActionController::Base
  before_action :ensure_www_domain


  private

  # Redirect non-www domain to www
  def ensure_www_domain
    if request.host == "llw-cs.com"
      redirect_to "#{request.protocol}www.llw-cs.com#{request.fullpath}", status: :moved_permanently
    end
  end

end
