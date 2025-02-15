# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include Clearance::Controller
    before_action :require_login
    
    before_action :set_locale
    # before_action :authenticate_admin
    before_action :set_paper_trail_whodunnit 
    helper_method :current_user_email

    before_action :set_cache_headers

    def require_superadmin
      unless current_user.role === "superadmin" 
        raise SecurityError, "Not Allowed"
      end
    end

    def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end    

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class,
                                           search_term).run
      super
    end
 
    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end
     
    def extract_locale
      parsed_locale = params[:locale]
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end

    def default_url_options
      super.merge(
        locale: I18n.locale
      )
    end

    # Overrides this to change nav state
    def nav_link_state(resource)
      comparable = resource_name.to_s.pluralize
      comparable == resource.to_s ? :active : :inactive
    end

    protected
    def user_for_paper_trail
      current_user.email ? current_user.email : 'Inconnu'
    end

    private
    def current_user_email
      session[:user_email]
    end

  end
end
