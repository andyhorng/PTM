class SystemDatasController < ApplicationController

  def index
    @system_data = SystemData.all
    @sets = @system_data.group_by {|d| d.name}
    # new datas is a hash which key is name(data) and value is value(data)
    @new_datas = @sets.keys.collect {|k| SystemData.new(:name => k)}.index_by {|d| d.name}
  end

  def create
    @system_data = SystemData.new(params[:system_data])
    if @system_data.save
      flash[:notice] = "Create successful!"
      redirect_to system_datas_url
    end
  end

  def destroy
    @system_data = SystemData.find(params[:id])
    @system_data.destroy
    redirect_to system_datas_url
  end

end
