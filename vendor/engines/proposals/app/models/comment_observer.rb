class CommentObserver < ActiveRecord::Observer
  include ProposalStatusUpdater

  def after_create(comment)
    update_proposal_status(comment.commentable) if comment.commentable.is_a? Proposal
  end
end


