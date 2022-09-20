class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[show update destroy]

  # GET /lectures
  def index
    @lectures = Lecture.by_not_lunch_nor_networking

    render json: @lectures
  end

  # GET /lectures/1
  def show
    render json: @lecture
  end

  # POST /lectures
  def create
    @lecture = Lecture.new(lecture_params)

    if @lecture.save
      TrackBuilder.create_schedule
      render json: @lecture, status: :created
    else
      render json: @lecture.errors, status: :unprocessable_entity
    end
  end

  def create_batch
    lines = lecture_batch_params[:file].tempfile.read.split("\n")
    Lecture.transaction do
      lines.each do |l|
        l.force_encoding('utf-8')
        Lecture.create!(name: l)
      end
    end
    TrackBuilder.create_schedule
    render json: Track.all, status: :created
  end

  # PATCH/PUT /lectures/1
  def update
    if @lecture.update(lecture_params)
      TrackBuilder.create_schedule
      render json: @lecture
    else
      render json: @lecture.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lectures/1
  def destroy
    @lecture.destroy
    TrackBuilder.create_schedule
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lecture
    @lecture = Lecture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lecture_params
    params.require(:lecture).permit(:name)
  end

  def lecture_batch_params
    params.require(:lecture).permit(:file)
  end
end
