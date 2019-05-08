# frozen_string_literal: true

class FiguresController < ApplicationController
  get "/figures/new" do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post "/figures" do # create action
    figure = Figure.new
    figure.name = params[:figure][:name]

    titles = Title.where(id: params[:figure][:title_ids])
    figure.titles = titles

    landmarks = Landmark.where(id: params[:figure][:landmark_ids])
    figure.landmarks = landmarks

    if params[:landmark][:name]
      figure.landmarks << Landmark.create(
        name: params[:landmark][:name],
        year_completed: params[:landmark][:year_completed]
      )
    end

    if params[:title][:name]
      figure.titles << Title.create(name: params[:title][:name])
    end

    figure.save
  end
end
