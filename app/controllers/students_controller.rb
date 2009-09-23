class StudentsController < ApplicationController

  before_filter :close_sh, :except => [:small_helper, :search_for_helper]
  helper_method :searching?

  # GET /students
  # GET /students.xml
  def index
    # clear session of :hours_ix
    session[:hours_ix] = nil

    if !searching?
      @students = Student.all
    else
      # searching!
      flash.now[:notice] = "請按清除離開搜尋結果"
      @students = session[:search_result]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
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


  # return search result
  def search str = session[:search_string]
    Student.find_by_sql(gen_searching_sql(str))
  end

  def search_for_index
    if params[:search_string] || searching?
      session[:searching] = true

      if !params[:search_string].blank?
        session[:search_result] = search
        session[:search_string] = params[:search_string]
      else
        session[:search_result] ||= search
        session[:search_string] ||= params[:search_string]
      end

      session[:search_result] = search
      @students = session[:search_result]
      flash.now[:notice] = "請按清除離開搜尋結果"
      # render search.html.erb
      render :update do |page|
        page.replace_html 'students_list', :partial => 'students', :object => @students
        page.replace_html 'flash_notice', :text => flash.now[:notice]
        page.visual_effect :highlight, 'students_list'
      end
    end
  end

  def search_for_helper
    logger.info("#search_for_helper(before): " + session[:sh_state].to_s)
    session[:search_string_for_helper] = params[:search_string]
    session[:small_helper_result] = search(session[:search_string_for_helper])
    render :partial => "students", :object => session[:small_helper_result], :locals => {:readonly => true}
    logger.info("#search_for_helper(after): " + session[:sh_state].to_s)
  end

  def back
    redirect_to students_url
  end

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

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])

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
    @hours = Hour.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end


  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])
    @student.hours = get_hours

    respond_to do |format|
      if @student.save
        flash[:notice] = 'Student was successfully created.'
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
    @student.hours = get_hours

    respond_to do |format|
      if @student.update_attributes(params[:student])
        flash[:notice] = 'Student was successfully updated.'
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
    session[:search_result] = nil
    redirect_to students_url
  end


  private

  def sh_opened?
    return session[:sh_state]
  end
  def open_sh
    session[:sh_state] = true
  end
  def close_sh
    session[:sh_state] = nil
  end

  def get_hours
    keys = params.keys.find_all {|key| key =~ /hour\d+/}

    keys.collect do |key|
        logger.info params[:"#{key}"]
        Hour.new(params[:"#{key}"])
    end
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
