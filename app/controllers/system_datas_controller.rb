class SystemDatasController < ApplicationController

  def index
    @system_datas = SystemData.all
    @new_data = @system_datas.collect do |d| 
      v = SystemDataValue.new 
      v.system_data = d
      v
    end.index_by {|v| v.system_data.name }
  end

  def create
    @system_data_value = SystemDataValue.new(params[:system_data_value])
    if @system_data_value.save
      flash[:notice] = I18n.t('flash.system_data.create_successful')
      redirect_to system_datas_url
    end
  end

  def destroy
    value = SystemDataValue.find(params[:id])
    value.destroy
    redirect_to system_datas_url
  end

end
