module Admin
  class CustomParentFiltersController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = CustomParentFilter.
    #     page(params[:page]).
    #     per(10)
    # end

    before_action :require_superadmin
    

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      result = CustomParentFilter.find_by(slug: param)
      result.blank? ? CustomParentFilter.find_by(id: param) : result
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
