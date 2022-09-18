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

  def lecture_batch_params
    params.require(:lecture).permit(:file)
  end

  def schedule_algorithm
    # Track.delete_all_tracks
    Track.all.each do |t|
      Lecture.find(t.lunch_id)&.destroy unless t.lunch_id.nil?
      Lecture.find(t.networking_id)&.destroy unless t.networking_id.nil?
      t.destroy
    end

    # Lecture.reset_all_lectures
    Lecture.update(start_time: nil, track: nil)

    lecs = []
    Lecture.order(duration: :desc).each { |l| lecs.append(l) }
    while lecs.count > 0
      track = Track.create
      # morning
      index = 0
      start_time = Time.utc(2000, 1, 1, 9)
      time_left = 180
      while time_left > 0 && index < lecs.count
        if lecs[index].duration <= time_left
          lec = lecs.delete_at(index)
          lec.update(start_time: start_time, track: track)
          time_left -= lec.duration
          start_time += lec.duration.minutes
        else
          index += 1
        end
      end
      lunch = Lecture.create(name: 'Almoço', duration: 60, start_time: Time.utc(2000, 1, 1, 12), track: track)
      track.update(lunch_id: lunch.id)
      # afternoon
      index = 0
      start_time = Time.utc(2000, 1, 1, 13)
      time_left = 240
      while time_left > 0 && index < lecs.count
        if lecs[index].duration <= time_left
          lec = lecs.delete_at(index)
          lec.update(start_time: start_time, track: track)
          time_left -= lec.duration
          start_time += lec.duration.minutes
        else
          index += 1
        end
      end
      time2 = Time.utc(2000, 1, 1, 16)
      start_time = time2 if start_time < time2
      networking = Lecture.create(name: 'Evento de Networking', duration: 60, start_time: start_time, track: track)
      track.update(networking_id: networking.id)
    end

  end

end
