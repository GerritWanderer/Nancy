class StaticController < ApplicationController
  def show
    layouts = %w(tutorials)
    layout = params[:path].split('_').first if layouts.include?(params[:path].split('_').first)
    render :layout => layout, :template => File.join('static', params[:locale].to_s, params[:path].split('_'))
  end
end
