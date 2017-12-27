class ProjectsController < ApplicationController
  layout 'admin'
  before_action :auth
  skip_before_action :auth, only: [:index, :create, :cancel]
  def auth
    begin
      project = Project.find(params[:project_id])
      if session[:user_id].to_s != project.user.id.to_s
        return redirect_to projectsIndex_path
      end
    rescue
      return redirect_to projectsIndex_path
    end
  end

  def cancel
    delete_session
    return redirect_to projectsIndex_path 
  end


  def index
  	#delete_session
  	@update = 0 
  	@current_user = current_user
    params[:page] ||= 1
    if !params[:page].to_i.is_a? Integer
      params[:page] = 1
    end
  	@projects = Project.where(user:@current_user).paginate(:page => params[:page], :per_page => 10)
    #@projects = Project.paginate(:page => params[:page], :per_page => 5)
    #@projects = Project.paginate(:page => 1, :per_page => 5)
  end


  def create
  	project = Project.new(project_params)
  	delete_session
  	session[:name]        = params.require(:project).permit(:name)[:name]
  	session[:technology]  = params.require(:project).permit(:technology)[:technology]
  	session[:description] = params.require(:project).permit(:description)[:description]
  	session[:link]        = params.require(:project).permit(:link)[:link]
  	session[:logo]        = params.require(:project).permit(:logo)[:logo]

      if project.valid?
        project.save
        delete_session
        flash[:failed] = []
      else
        flash[:failed] = project.errors.full_messages
      end
  	return redirect_to projectsIndex_path
  end

  def destroy
  	Project.delete(params[:project_id])
  	delete_session
  	return redirect_to projectsIndex_path
  end



  def edit
  	@update = 1
  	@current_user = current_user
  	@projects = Project.where(user:@current_user).paginate(:page => 1, :per_page => 10)
  	delete_session
    begin
    	project = Project.find(params[:project_id])
    	session[:project_id]  = project.id
    	session[:name]        = project.name
      session[:technology]  = project.technology
    	session[:description] = project.description
    	session[:link]        = project.link
    	session[:logo]        = project.logo
    	return render 'index'
    rescue 
      return redirect_to projectsIndex_path
    end
  end

  def update
  	session[:project_id]  = params[:project_id]
  	session[:name]        = params.require(:project).permit(:name)[:name]
  	session[:technology]  = params.require(:project).permit(:technology)[:technology]
  	session[:description] = params.require(:project).permit(:description)[:description]
  	session[:link]        = params.require(:project).permit(:link)[:link]
  	session[:logo]        = params.require(:project).permit(:logo)[:logo]
  	project = Project.find(params[:project_id])
  	project.update(project_params2)
  	if project.valid?
  		delete_session
      flash[:failed] = []
  		return redirect_to projectsIndex_path 
  	else
  		flash[:failed] = project.errors.full_messages
  		@current_user = current_user
  	    @projects = Project.where(user:@current_user).paginate(:page => 1, :per_page => 10)
  	    @update = 1
  		return render 'index'
  	end
  end


  private

  def delete_session
  	if session.key? 'project_id'
  		session.delete(:project_id)
  	end
  	if session.key? 'name'
  		session.delete(:name)
  	end
  	if session.key? 'technology'
  		session.delete(:technology)
  	end
  	if session.key? 'description'
  		session.delete(:description)
  	end
  	if session.key? 'link'
  		session.delete(:link)
  	end
  	if session.key? 'logo'
  		session.delete(:logo)
  	end
  end

  def project_params
  	params.require(:project).permit(:name, :technology, :description, :link, :logo).merge(user:current_user)
  end

  def project_params2
  	params.require(:project).permit(:name, :technology, :description, :link, :logo)
  end

end
