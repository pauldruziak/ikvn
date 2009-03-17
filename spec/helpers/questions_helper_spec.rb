require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestionsHelper do
  #include AuthenticatedSystem
  def mock_admin
    @admin ||= mock_model(User, :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 						       
						       :roles  => [mock_model(Role, {:name => "admin", :save => true})])  
  end
  
  def mock_season(options={})
  	@mock_season ||= mock_model(Season, { :name => 'first season', 
  	                                      :rounds => []}.merge(options))
  end
  
  def mock_round(options={})
  	@mock_round ||= mock_model(Round, { :name => 'first season',
  	                                    :questions => [], 
  	                                    :published => false,
  	                                    :season => mock_season}.merge(options))
  end

  def mock_question(options={})
    @mock_question ||= mock_model(Question, { :name => 'first question',
                                              :body => 'body question',
                                              :update_attributes => true, 
                                              :round => mock_round}.merge(options))
  end

  
  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(QuestionsHelper)
  end
 
end
