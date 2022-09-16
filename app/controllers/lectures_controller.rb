class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[show update destroy]

  # GET /lectures
  def index
    @lectures = Lecture.all

    render json: @lectures
  end

  # GET /lectures/1
  def show
    render json: @lecture
  end

  # POST /lectures
  def create
    @lecture = Lecture.new(parse_lecture(lecture_params[:name]))

    if @lecture.save
      render json: @lecture, status: :created
    else
      render json: @lecture.errors, status: :unprocessable_entity
    end
  end

  def create_batch
    lines = lecture_batch_params[:file].tempfile.read.split("\n")
    lines.each do |l|
      Lecture.create(parse_lecture(l))
    end
    render json: Lecture.all, status: :created
  end

  # PATCH/PUT /lectures/1
  def update
    if @lecture.update(lecture_params)
      render json: @lecture
    else
      render json: @lecture.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lectures/1
  def destroy
    @lecture.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lecture
    @lecture = Lecture.find(params[:id])
  end

  def parse_lecture(name)
    last_string = name.split.last
    if last_string == 'lightning'
      duration = 5
    else
      duration = last_string.delete('a-zA-Z').to_i
    end
    { name: name, duration: duration }
  end

  # Only allow a list of trusted parameters through.
  def lecture_params
    params.require(:lecture).permit(:name)
  end

  def lecture_batch_params
    params.require(:lecture).permit(:file)
  end
end
