class SkillsController < ApplicationController
  layout 'admin'
  before_action :auth
  skip_before_action :auth, only: [:new, :index, :create, :cancel]
  def auth
    begin
      skill = Skill.find(params[:skill_id])
      if session[:user_id].to_s != skill.user.id.to_s
        return redirect_to skillsIndex_path
      end
    rescue
      return redirect_to skillsIndex_path
    end
  end


  def new
  end

  def cancel
    delete_session
    return redirect_to skillsIndex_path 
  end

  def index
  	#delete_session
  	@update = 0 
  	@current_user = current_user
    params[:page] ||= 1
    if !params[:page].to_i.is_a? Integer
      params[:page] = 1
    end
  	@skills = Skill.where(user:@current_user).paginate(:page => params[:page], :per_page => 10)
    @page   = params[:page]
  end


  def create
  	skill = Skill.new(skill_params)
  	delete_session
  	session[:name]    = params.require(:skill).permit(:name)[:name]
  	session[:category]    = params.require(:skill).permit(:category)[:category]
  	session[:years]   = params.require(:skill).permit(:years)[:years]
  	session[:comment] = params.require(:skill).permit(:comment)[:comment]

  	if skill.valid?
  		skill.save
  		delete_session
      flash[:failed] = []
  	else
  		flash[:failed] = skill.errors.full_messages
  	end
  	return redirect_to skillsIndex_path
  end

  def destroy
  	Skill.delete(params[:skill_id])
  	delete_session
  	return redirect_to skillsIndex_path
  end



  def edit
  	@update = 1
  	@current_user = current_user
  	@skills = Skill.where(user:@current_user).paginate(:page => 1, :per_page => 10)
  	delete_session
    begin
    	skill = Skill.find(params[:skill_id])
    	session[:skill_id]= skill.id
    	session[:name]    = skill.name
    	session[:category]= skill.category
    	session[:years]   = skill.years
    	session[:comment] = skill.comment
    	return render 'index'
    rescue 
      return redirect_to skillsIndex_path
    end

  end

  def update
    session[:skill_id]= params[:skill_id]
  	session[:name]    = params.require(:skill).permit(:name)[:name]
  	session[:category]= params.require(:skill).permit(:category)[:category]
  	session[:years]   = params.require(:skill).permit(:years)[:years]
  	session[:comment] = params.require(:skill).permit(:comment)[:comment]
  	skill = Skill.find(params[:skill_id])
  	skill.update(skill_params2)
  	if skill.valid?
  		delete_session
      flash[:failed] = []
  		return redirect_to skillsIndex_path 
  	else
  		flash[:failed] = skill.errors.full_messages
  		@current_user = current_user
  	    @skills = Skill.where(user:@current_user).paginate(:page => 1, :per_page => 10)
  	    @update = 1
  		return render 'index'
  	end
  end


  private

  def delete_session

  	if session.key? 'skill_id'
  		session.delete(:skill_id)
  	end

  	if session.key? 'name'
  		session.delete(:name)
  	end
  	if session.key? 'category'
  		session.delete(:category)
  	end
  	if session.key? 'years'
  		session.delete(:years)
  	end
  	if session.key? 'comment'
  		session.delete(:comment)
  	end
  end

  def skill_params
  	params.require(:skill).permit(:name, :category, :years, :comment).merge(user:current_user)
  end

  def skill_params2
  	params.require(:skill).permit(:name, :category, :years, :comment)
  end
end
