module AnswersHelper
  def can_add_answer?(question)
    signed_in? && question.round.open? && question.answers.my(current_user).empty?
  end

  def can_edit_answer?(question)
    signed_in? && question.round.open?
  end
end
