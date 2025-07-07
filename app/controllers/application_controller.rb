class ApplicationController < ActionController::Base
  before_action :ensure_www_domain
  before_action :track_ahoy_visit
  after_action :track_page_view

  private

  # Redirect non-www domain to www
  def ensure_www_domain
    if request.host == "llw-cs.com"
      redirect_to "#{request.protocol}www.llw-cs.com#{request.fullpath}", status: :moved_permanently
    end
  end

  # Track visit only if not already tracked
  def track_ahoy_visit
    ahoy.track_visit unless ahoy.visit
  end

  # Track page view after action
  def track_page_view
    ahoy.track(
      "Viewed #{controller_name}##{action_name}",
      request.path_parameters
    )
  end
end
