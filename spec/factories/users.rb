  Factory.define :user, :class => User do |u|
    u.login 'enej'
    u.name  'Pasha Druzyak'
    u.email 'quire@example.com'
    u.password 'quire69' 
    u.password_confirmation 'quire69' 
  end