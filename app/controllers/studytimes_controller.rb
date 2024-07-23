class StudytimesController < ApplicationController
  before_action :set_studytime, only: %i[ show edit update destroy ]

  

  # GET /studytimes or /studytimes.json
  def index
    user_studytimes = Studytime.where(user_id: current_user.id).order(created_at: :desc)
    @studytimes = user_studytimes.page(params[:page]).per(12)
    @calc_studytimes = Studytime.all.order(created_at: :desc)
    @today_studytimes = @calc_studytimes.today
    @serch_other_users_studytimes = Studytime.where.not(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(12)

    if user_signed_in?
      #今日の勉強時間の"時間"と"分"の合計をそれぞれ取得し計算する
      @today_studytime_hours = @today_studytimes.where(user_id: current_user.id).sum(:studytime_hours)
      @today_studytime_minutes = @today_studytimes.where(user_id: current_user.id).sum(:studytime_minutes)
      @todays_total_studytime_hours = @today_studytime_hours + (@today_studytime_minutes / 60)
      @todays_total_studytime_minutes = @today_studytime_minutes % 60
      #今までの勉強時間の"時間"と"分"の合計をそれぞれ取得し計算する
      @all_studytime_hours = @calc_studytimes.where(user_id: current_user.id).sum(:studytime_hours)
      @all_studytime_minutes = @calc_studytimes.where(user_id: current_user.id).sum(:studytime_minutes)
      @total_all_studytime_hours = @all_studytime_hours + (@all_studytime_minutes / 60)
      @total_all_studytime_minutes = @all_studytime_minutes % 60
    end
  end

  # GET /studytimes/1 or /studytimes/1.json
  def show
    @studytime = Studytime.find(params[:id])
  end

  # GET /studytimes/new
  def new
    @studytime = Studytime.new
  end

  # GET /studytimes/1/edit
  def edit
    @studytime = Studytime.find(params[:id])
  end

  # POST /studytimes or /studytimes.json
  def create
    @user = User.find_by(id: session[:user_id])
    @studytime = Studytime.new(
      studytime_params
    )
    @studytime.user_id = current_user.id
    respond_to do |format|
      if @studytime.save
        format.html { redirect_to studytime_url(@studytime), notice: "記録が保存されました。" }
        format.json { render :index, status: :created, location: @studytime }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @studytime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /studytimes/1 or /studytimes/1.json
  def update
    respond_to do |format|
      if @studytime.update(studytime_params)
        format.html { redirect_to studytime_url(@studytime), notice: "記録を更新しました" }
        format.json { render :show, status: :ok, location: @studytime }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @studytime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /studytimes/1 or /studytimes/1.json
  #def destroy
  #  @studytime.destroy!

   # respond_to do |format|
    #  format.html { redirect_to studytimes_url, notice: "記録を削除しました" }
     # format.json { head :no_content }
    #end
  #end

  def destroy
    @studytime = Studytime.find(params[:id])
    @studytime.destroy
    redirect_to studytimes_path, notice: '記事が削除されました。'
  end

  def search_users
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
  

  def user_studytime
    @user = User.find_by(name: params[:user_name])
    if @user.nil?
      redirect_to studytimes_path, alert: "ユーザーが見つかりませんでした"
      return
    end
    @studytimes = Studytime.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(12)
    @calc_studytimes = Studytime.all.order(created_at: :desc)
    @today_studytimes = @calc_studytimes.today

    @today_studytime_hours = @today_studytimes.where(user_id: @user.id).sum(:studytime_hours)
    @today_studytime_minutes = @today_studytimes.where(user_id: @user.id).sum(:studytime_minutes)
    @todays_total_studytime_hours = @today_studytime_hours + (@today_studytime_minutes / 60)
    @todays_total_studytime_minutes = @today_studytime_minutes % 60

    @all_studytime_hours = @calc_studytimes.where(user_id: @user.id).sum(:studytime_hours)
    @all_studytime_minutes = @calc_studytimes.where(user_id: @user.id).sum(:studytime_minutes)
    @total_all_studytime_hours = @all_studytime_hours + (@all_studytime_minutes / 60)
    @total_all_studytime_minutes = @all_studytime_minutes % 60
  end

  private

  def set_studytime
    @studytime = Studytime.find_by(id: params[:id])
  end

  def studytime_params
    params.require(:studytime).permit(:studytime_hours, :studytime_minutes, :memo, :image, :created_at).merge(user_id: current_user.id)
  end
  


  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_studytime
      @studytime = Studytime.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def studytime_params
      params.require(:studytime).permit(:studytime_hours, :studytime_minutes, :memo, :image, :created_at).merge(user_id: current_user.id)
    end

end
