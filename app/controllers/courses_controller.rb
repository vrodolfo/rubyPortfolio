class CoursesController < ApplicationController
  layout 'admin'
  before_action :auth
  skip_before_action :auth, only: [:new, :index, :create, :cancel]
  def auth
    begin 
      course = Course.find(params[:education_id])
      if session[:user_id].to_s != course.user.id.to_s
        return redirect_to coursesIndex_path
      end
    rescue
      return redirect_to coursesIndex_path
    end
  end

  def new
  end

  def cancel
    delete_session
    return redirect_to coursesIndex_path 
  end

  def index
  	#delete_session
    params[:page] ||= 1
    if !params[:page].to_i.is_a? Integer
      params[:page] = 1
    end
  	@update = 0 
  	@current_user = current_user
  	@educations = Course.where(user:@current_user).paginate(:page => params[:page], :per_page => 10)
  end


  def create
  	education = Course.new(education_params)
  	delete_session
  	session[:name]        = params.require(:education).permit(:name)[:name]
  	session[:category]    = params.require(:education).permit(:category)[:category]
  	session[:school]      = params.require(:education).permit(:school)[:school]
  	session[:start]       = params.require(:education).permit(:start)[:start]
  	session[:end]         = params.require(:education).permit(:end)[:end]
  	session[:status]      = params.require(:education).permit(:status)[:status]
  	session[:city]        = params.require(:education).permit(:city)[:city]
  	session[:country]     = params.require(:education).permit(:country)[:country]
  	session[:description] = params.require(:education).permit(:description)[:description]
  	session[:website]     = params.require(:education).permit(:website)[:website]
  	session[:logo]        = params.require(:education).permit(:logo)[:logo]

    startDate = params.require(:education).permit(:start)[:start]
    endDate = params.require(:education).permit(:end)[:end]


    if startDate > endDate
      flash[:failed] = ["Start Date cannot be after end date"]
    else
      if education.valid?
        education.save
        delete_session
        flash[:failed] = []
      else
        flash[:failed] = education.errors.full_messages
      end
    end
  	return redirect_to coursesIndex_path
  end

  def destroy
  	Course.delete(params[:education_id])
  	delete_session
  	return redirect_to coursesIndex_path
  end

  def edit
  	@update = 1
  	@current_user = current_user
  	@educations = Course.where(user:@current_user).paginate(:page => 1, :per_page => 10)
  	delete_session
    begin
    	education = Course.find(params[:education_id])
    	session[:education_id]= education.id
    	session[:name]        = education.name
    	session[:category]    = education.category
    	session[:school]      = education.school
    	session[:start]       = education.start
    	session[:end]         = education.end
    	session[:status]      = education.status
    	session[:city]        = education.city
    	session[:country]     = education.country
    	session[:description] = education.description
    	session[:website]     = education.website
    	session[:logo]        = education.logo
    	return render 'index'
    rescue
      return redirect_to coursesIndex_path
    end
  end

  def update
  	session[:education_id]= params[:education_id]
  	session[:name]        = params.require(:education).permit(:name)[:name]
  	session[:category]    = params.require(:education).permit(:category)[:category]
  	session[:school]      = params.require(:education).permit(:school)[:school]
  	session[:start]       = params.require(:education).permit(:start)[:start]
  	session[:end]         = params.require(:education).permit(:end)[:end]
  	session[:status]      = params.require(:education).permit(:status)[:status]
  	session[:city]        = params.require(:education).permit(:city)[:city]
  	session[:country]     = params.require(:education).permit(:country)[:country]
  	session[:description] = params.require(:education).permit(:description)[:description]
  	session[:website]     = params.require(:education).permit(:website)[:website]
  	session[:logo]        = params.require(:education).permit(:logo)[:logo]
  	education = Course.find(params[:education_id])
  	education.update(education_params2)
  	if education.valid?
  		delete_session
      flash[:failed] = []
  		return redirect_to coursesIndex_path 
  	else
  		flash[:failed] = education.errors.full_messages
  		@current_user = current_user
  	  @educations = Course.where(user:@current_user).paginate(:page => 1, :per_page => 10)
  	  @update = 1
  		return render 'index'
  	end
  end


  private

  def delete_session
  	if session.key? 'education_id'
  		session.delete(:education_id)
  	end
  	if session.key? 'name'
  		session.delete(:name)
  	end
  	if session.key? 'category'
  		session.delete(:category)
  	end
  	if session.key? 'school'
  		session.delete(:school)
  	end
  	if session.key? 'start'
  		session.delete(:start)
  	end
  	if session.key? 'end'
  		session.delete(:end)
  	end
  	if session.key? 'status'
  		session.delete(:status)
  	end
  	if session.key? 'city'
  		session.delete(:city)
  	end
  	if session.key? 'country'
  		session.delete(:country)
  	end
  	if session.key? 'description'
  		session.delete(:description)
  	end
  	if session.key? 'website'
  		session.delete(:website)
  	end
  	if session.key? 'logo'
  		session.delete(:logo)
  	end
  end

  def education_params
  	params.require(:education).permit(:name, :category, :school, :start, :end, :status, :city, :country, :description, :website, :logo).merge(user:current_user)
  end

  def education_params2
  	params.require(:education).permit(:name, :category, :school, :start, :end, :status, :city, :country, :description, :website, :logo)
  end
end
