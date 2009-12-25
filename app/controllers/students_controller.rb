class StudentsController < ApplicationController

  helper_method :searching?

  # GET /students
  # GET /students.xml
  def index
    if !searching?
      # @students = Student.all
      @students = Student.paginate :page => params[:page]
    else
      # searching!
      flash.now[:notice] = I18n.t('flash.student.clear')
      @students = search
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  def recently_changed
    @students = Student.paginate(:all, :conditions => ['updated_at >= ?', "#{Date.today - 3}"],
                                 :order => 'updated_at DESC',:page => params[:page])
  end

=begin
  def search
    if !params[:search_string].blank? || searching?
      if !request.xhr?
        session[:searching] = true
      end
      session[:search_string] ||= params[:search_string]

      @students = Student.find_by_sql(gen_searching_sql(session[:search_string]))

      unless request.xhr?
        session[:search_result] = @students
        flash.now[:notice] = "按返回離開搜尋結果！"
        # render search.html.erb
      else
        # xhr 
        session[:small_helper_result] = @students
        render :partial => "students", :object => session[:small_helper_result], :locals => {:readonly => true}
      end
    else
      unless request.xhr?
        redirect_to students_url
      else
        # xhr
        render :partial => "students", :object => []
      end
    end
  end
=end



  def search_for_index
    if params[:search_string] || searching?
      session[:searching] = true
      session[:search_string] = params[:search_string]
      @students = search
      flash.now[:notice] = I18n.t('flash.student.clear')
      # render search.html.erb
      # render :update do |page|
      #   page.replace_html 'students_list', :partial => 'students', :object => @students, :locals => {:column => 2}
      #   page.replace_html 'flash_notice', :text => flash.now[:notice]
      #   page.visual_effect :highlight, 'students_list'
      # end
      redirect_to students_url
    end
  end

  def search_for_helper
    if !params[:search_string].blank? 
      session[:search_string_for_helper] = params[:search_string]
      session[:small_helper_result] = 
        Student.find_by_sql(gen_searching_sql(session[:search_string_for_helper]))
    end 
    render :partial => "students", :object => session[:small_helper_result], :locals => {:readonly => true}
  end

  def back
    redirect_to students_url
  end
=begin
  def small_helper
    session[:small_helper_result] ||= []
    if sh_opened?
      close_sh
      render :update do |page|
        page.visual_effect :blind_up, 'small_helper'
        page.delay do 
          page.remove "small_helper"
        end
      end
    else
      open_sh
      render :update do |page|
        page.insert_html :bottom, "content", :partial => "small_helper"
        page.visual_effect :blind_down, 'small_helper'
      end
    end
    logger.info("#small_helper: " + session[:sh_state].to_s)
  end
=end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])
    @hours = @student.hours

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new
    # @student.hours << Hour.new
    @hours = [Hour.new]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
    @hours = @student.hours
  end


  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        flash[:notice] = I18n.t('flash.student.create_successful')
        format.html { redirect_to(@student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        flash[:notice] = I18n.t('flash.student.update_successful') 
        format.html { redirect_to(@student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.hours.each{|h| h.destroy}
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end

  def end_searching
    session[:searching] = false
    session[:search_string] = nil
    redirect_to students_url
  end

  private

  # return search result
  def search str = session[:search_string]
    Student.paginate_by_sql(gen_searching_sql(str), :page => params[:page])
  end


  def gen_searching_sql(search_string)
    column_for_search = Student.column_names
    holder = []
    column_for_search.each do |column|
      holder << " #{column} like ? "
    end
    holder_str = holder.join(" OR ")

    ["select * from students where " + holder_str, 
      *(["%#{search_string}%"] * column_for_search.size)]
  end
  def searching(search_string)
  end
  def searching?
    session[:searching]
  end

  def open_small_helper
  end

  def close_small_helper
    session[:small_helper_opened?] = nil
  end

end
