class JobPostingAnswersController < ApplicationController
  before_action :set_job_posting_answer, only: [:show, :edit, :update, :destroy]

  # GET /job_posting_answers
  # GET /job_posting_answers.json
  # def index
  #   @job_posting_answers = JobPostingAnswer.all
  # end

  # GET /job_posting_answers/1
  # GET /job_posting_answers/1.json
  def show
  end

  # GET /job_posting_answers/new
  def new
    @job_posting = JobPosting.find(params[:job_posting_id])
    @job_application = JobApplication.find(params[:job_application_id])
    @all_questions = @job_posting.job_posting_questions.all
    @page_answers = []
    @job_posting.job_posting_questions.count.times do
      @page_answers << JobPostingAnswer.new
    end
  end

  # GET /job_posting_answers/1/edit
  # def edit
  # end

  # POST /job_posting_answers
  # POST /job_posting_answers.json
  def create
    p params["answers"]
    params["answers"].each do |key, answer|
      # p answer
      @answer = JobPostingAnswer.create(answer_params(answer))
    end
    @job_application_id = @answer.job_application_id
    redirect_to finalize_job_application_path(:id => @job_application_id)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_posting_answer
      @job_posting = JobPosting.find(params[:job_posting_id])
      @job_application = @job_posting.job_applications.find(params[:job_application_id])
      @job_posting_answer = @job_application.job_posting_answers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def job_posting_answer_params
    #   params.require(:job_posting_answer).permit(:content, :job_application_id)
    # end

    def answer_params(my_params)
      my_params.permit(:content, :job_posting_questions_id, :job_application_id)
    end


  #   @job_posting_answer = JobPostingAnswer.new(job_posting_answer_params)

  #   respond_to do |format|
  #     if @job_posting_answer.save
  #       format.html { redirect_to @job_posting_answer, notice: 'Job posting answer was successfully created.' }
  #       format.json { render :show, status: :created, location: @job_posting_answer }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @job_posting_answer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /job_posting_answers/1
  # PATCH/PUT /job_posting_answers/1.json
  # def update
  #   respond_to do |format|
  #     if @job_posting_answer.update(job_posting_answer_params)
  #       format.html { redirect_to @job_posting_answer, notice: 'Job posting answer was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @job_posting_answer }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @job_posting_answer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /job_posting_answers/1
  # DELETE /job_posting_answers/1.json
  # def destroy
  #   @job_posting_answer.destroy
  #   respond_to do |format|
  #     format.html { redirect_to job_posting_answers_url, notice: 'Job posting answer was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

end
