module RoundsHelper
  def human_date(round)
  	if round.end_responses_at > Time.now
  	  "завершился " + time_ago_in_words(round.end_responses_at)
  	else
  	  "до начала " + distance_of_time_in_words_to_now(round.start_responses_at)
  	end
  end
end
