class PollsController < ApplicationController
  before_action :logged_in_user
  before_action :set_poll, only: [:show, :vote, :destroy]
  before_action :correct_user, only: :destroy
  
  def index
    @polls = Poll.includes(:user, poll_options: :poll_votes)
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 10)
  end

  def show
    @poll = Poll.includes(:user, poll_options: :poll_votes).find(params[:id])
    @user_vote = @poll.user_vote(current_user) if logged_in?
  end

  def new
    @poll = current_user.polls.build
    3.times { @poll.poll_options.build }
  end

  def create
    @poll = current_user.polls.build(poll_params)
    if @poll.save
      flash[:success] = "Poll created successfully!"
      redirect_to @poll
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  def vote
    unless can_vote_on_poll?(@poll)
      flash[:danger] = "You can only vote on polls from people you follow"
      redirect_to @poll and return
    end
    
    if @poll.voted_by?(current_user)
      flash[:warning] = "You have already voted on this poll"
      redirect_to @poll and return
    end
    
    poll_option = @poll.poll_options.find(params[:option_id])
    vote = current_user.poll_votes.build(poll_option: poll_option)
    
    if vote.save
      flash[:success] = "Vote recorded successfully!"
    else
      flash[:danger] = "Unable to record your vote"
    end
    
    redirect_to @poll
  end
  
  def destroy
    @poll.destroy
    flash[:success] = "Poll deleted successfully"
    redirect_to polls_path, status: :see_other
  end

  private

  def poll_params
    params.require(:poll).permit(:question,
                                  poll_options_attributes: [:id, :option_text, :_destroy])
  end
  
  def set_poll
    @poll = Poll.find(params[:id])
  end
  
  def can_vote_on_poll?(poll)
    current_user == poll.user || current_user.following?(poll.user)
  end
  
  def correct_user
    redirect_to polls_path unless current_user == @poll.user
  end
end
