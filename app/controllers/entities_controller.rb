# encoding: UTF-8
class EntitiesController < ApplicationController
  def index
    @entities = Entity.all

    respond_with @entities
  end

  def show
    @entity = Entity.find(params[:id])
    @opinions = Opinion.where(:entity_id => params[:id])
    @corrected_opinions = Array.new

    @opinions.each do |opinion|
      corrected_opinion = CorrectedOpinion.where(:opinion_id => opinion.id).first
      @corrected_opinions << corrected_opinion unless corrected_opinion.nil?
    end

    @cleaned_opinions = Array.new

    @opinions.each do |opinion|
      cleaned_opinion = CleanedOpinion.where(:opinion_id => opinion.id).first
      @cleaned_opinions << cleaned_opinion unless cleaned_opinion.nil?
    end

    respond_with @entity
  end

  def new
    respond_with @entity = Entity.new
  end
  
  def edit
    @entity = Entity.find(params[:id])
  end

  def create
    respond_with @entity = Entity.create(params[:entity])
  end

  def update
    @entity = Entity.find(params[:id])
    @entity.update_attributes(params[:entity])
    respond_with @entity
  end

  def destroy
    @entity = Entity.find(params[:id])
    respond_with @entity.destroy
  end
end