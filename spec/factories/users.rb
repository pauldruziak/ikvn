  Factory.define :user, :class => User do |u|
    u.login 'enej'
    u.name  'Pasha Druzyak'
    u.email 'quire@example.com'
    u.password 'quire69' 
    u.password_confirmation 'quire69' 
  end
  
  Factory.define :quentin, :class => User do |u|
    u.login                     'quentin2'
    u.name                      'Pasha Druzyak'
    u.email                     'quentin@example.com'
    u.password                  'monkey' 
    u.password_confirmation     'monkey' 
    #u.salt                      '356a192b7913b04c54574d18c28d46e6395428ab' # SHA1('0')
    #u.crypted_password          '5182209750da234dd45813f6a8a5e98d88e50d02' # 'monkey'
    #u.created_at                { 5.days.ago  }
    #u.remember_token_expires_at { 1.days.from_now }
    #u.remember_token            '77de68daecd823babbb58edb1c8e14d7106e83bb'
    #u.activated_at              { 5.days.ago  }
  end
  
  Factory.define :aaron, :class => User do |u|
    u.login                     'aaron'
    u.email                     'aaron@example.com'
    u.salt                      'da4b9237bacccdf19c0760cab7aec4a8359010b0' # SHA1('1')
    u.crypted_password          'cf66a6a8d5c55f5f0d30fd0f7ff9919e8dc3f219' # 'monkey'
    u.created_at                { 1.days.ago.to_s  }
    u.remember_token_expires_at
    u.remember_token            
    u.activation_code           '1b6453892473a467d07372d45eb05abc2031647a'
    u.activated_at              
  end
 
  Factory.define :old_password_holder, :class => User do |u|
    u.login                     'old_password_holder'
    u.email                     'salty_dog@example.com'
    u.salt                      '7e3041ebc2fc05a40c60028e2c4901a81035d3cd'
    u.crypted_password          '00742970dc9e6319f8019fd54864d3ea740f04b1' # test
    u.created_at                { 1.days.ago.to_s  }
    u.activation_code          
    u.activated_at              { 5.days.ago.to_s }
  end