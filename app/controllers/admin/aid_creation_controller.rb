
module Admin
  class AidCreationController < Admin::ApplicationController

    def dashboard
      @dashboard ||= AidDashboard.new
    end

    def new_aid_stage_1
      resource = Aid.new
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }      
    end

    def new_aid_stage_2
      resource = Aid.find_by(slug: params[:slug])
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }      
    end

    def create_stage_1
      resource = Aid.new(params.require(:aid).permit(:source, :name, :contract_type_id, :ordre_affichage))

      if resource.save
        redirect_to(
          admin_aid_creation_new_aid_stage_2_path(slug: resource.slug),
          notice: "L'aide a bien été enregistrée comme brouillon. Vous pouvez maintenant renseigner le contenu ou reprendre l'édition plus tard. ",
        )
      else
        render :new_aid_stage_1, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end     
    end

  end
end
