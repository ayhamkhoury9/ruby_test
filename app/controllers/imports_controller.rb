class ImportsController < ApplicationController
  def create
    file = params[:file]
    type = params[:type]

    if file && type
      file_path = file.path
      ImportCsvJob.perform_later(file_path, type)
      render json: { status: 'Import started' }, status: :accepted
    else
      render json: { error: 'File and type parameters are required' }, status: :unprocessable_entity
    end
  end
end
