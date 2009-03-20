  Factory.define :member, :class => Role do |r|
    r.name  'member'
  end
  
  Factory.define :judge, :class => Role do |r|
    r.name  'judge'
  end
  
  Factory.define :admin, :class => Role do |r|
    r.name  'admin'
  end