class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  layout :resolve_layout

  def resolve_layout
    case action_name
    when "index"
      "application"
    else
      "admin"
    end
  end

  def index
    #@current_user = current_user
    @admin      = User.find_by(role:'admin')

    params[:pageSkills] ||= 1
    params[:pageEdu] ||= 1
    params[:pageProjects] ||= 1
    if !params[:pageSkills].to_i.is_a? Integer
      params[:pageSkills] = 1
    end
    if !params[:pageEdu].to_i.is_a? Integer
      params[:pageEdu] = 1
    end
    if !params[:pageProjects].to_i.is_a? Integer
      params[:pageProjects] = 1
    end

    @skills       = Skill.where(user:@admin).order("category ASC, years DESC").paginate(:page => params[:pageSkills], :per_page => 10)
    @educations   = Course.where(user:@admin).order("start DESC").paginate(:page => params[:pageEdu], :per_page => 10)
    @projects     = Project.where(user:@admin).order("technology DESC").paginate(:page => params[:pageProjects], :per_page => 10)
    @pageSkills   = params[:pageSkills]
    @pageEdu      = params[:pageEdu]
    @pageProjects = params[:pageProjects]
    
    #Total Pages
    @skillsPages   = (Skill.where(user:@admin).order("category ASC, years DESC").count/10.to_f).ceil
    @eduPages      = (Course.where(user:@admin).order("start DESC").count/10.to_f).ceil
    @projectsPages = (Project.where(user:@admin).order("technology DESC").count/10.to_f).ceil
        
  end

  def new
    if session.key? 'user_id'
      return redirect_to main_path current_user.id
    end
  end

  def email
    @user = User.find_by(role:'admin')
    # ApplicationMailer.mail(to: @user.email, subject: 'Sample Email').deliver
    # @test = ContactMail.contactEmail(@user).deliver
    # p @test
    begin
      cc = ENV['ccemail']
      ContactMail.contactEmail(@user, params, cc).deliver
      session[:email] = 1
    rescue
      return redirect_to root_path(1, 1, 1)
    end
  	return redirect_to root_path(1, 1, 1)
  end

  def create
  	session.clear
  	user = User.find_by(email:params[:email])
  	session[:email2] = params[:email]
  	if user
  		if user.try(:authenticate, params[:password])
  			session.clear
  			session[:user_id] = user.id
  			flash[:success] = ["success"]
  			return redirect_to main_path user.id
  		else
  			flash[:failed] = ["Invalid Password"]
  		end
  	else
  		flash[:failed] = ["Invalid Email"]
  	end
  	return redirect_to :back #sessionsNew_path
  end

  def destroy
    session.clear
  	if session.key? 'user_id'
  		session.delete(:user_id)
  	end
  	return redirect_to root_path(1, 1, 1)
  end
end
