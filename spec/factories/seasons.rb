  Factory.define :season, :class => Season do |s|
    s.name 'First'
    s.rounds_count  5
    s.questions_count 3
    s.rounds {|r| [] }
  end