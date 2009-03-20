  Factory.define :question, :class => Question do |q|
    q.name 'First'
    q.body  'Hello world!'
    #s.rounds {|r| [r.association(:round), r.association(:round)] }
  end