  Factory.define :round, :class => Round do |r|
    r.name 'First'
    r.published false
    r.start_responses_at Time.now
    r.end_responses_at(Time.now + 14.day)
    r.start_assess_at(Time.now + 14.day)
    r.end_assess_at(Time.now + 21.day)
    #r.association :season, :factory => :season
    r.questions {|q| [q.association(:question), q.association(:question)] }
  end