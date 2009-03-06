require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Season do
  def create_season(options = {})
    record = Season.new({ :name => 'test', :rounds_count => 5, :questions_count => 3 }.merge(options))
    record.save
    record  	
  end
  
  before(:each) do     
    @params = { :name => 'test', :rounds_count => 5, :questions_count => 3 }
  end
  
  describe 'when creating' do 
    it "should require name" do
      season = create_season(:name => nil)
      season.errors.on(:name).should_not be_nil
    end
  
    it "should require rounds_count:" do
      season = create_season(:rounds_count => nil)
  	  season.errors.on(:rounds_count).should_not be_nil
    end
  
    it "should require questions_count" do
      season = create_season(:questions_count => nil)  	  
  	  season.errors.on(:questions_count).should_not be_nil
    end
    
    describe "should allows legitimate name:" do
      ['a'*100, 'test'].each do |name|
      	it "'#{name}'" do
      	  lambda do
            season = create_season(:name => name)
            season.should_not have(1).error_on(:name)
          end.should change(Season, :count)
      	end
      end      
    end
    
    describe "should allows legitimate rounds_count:" do
      [1, 5, 30].each do |rounds_count|
      	it "'#{rounds_count}'" do
      	  lambda do
            season = create_season(:rounds_count => rounds_count)
            season.should_not have(1).error_on(:rounds_count)
          end.should change(Season, :count)
      	end
      end      
    end
    
    describe "should allows legitimate questions_count:" do
      [1, 5, 30].each do |questions_count|
      	it "'#{questions_count}'" do
      	  lambda do
            season = create_season(:questions_count => questions_count)
            season.should_not have(1).error_on(:questions_count)
          end.should change(Season, :count)
      	end
      end      
    end    
    
    describe "should disallows illegitimate name:" do
      ['a'*100, 'test'].each do |name|
      	it "'#{name}'" do
      	  lambda do
            season = create_season(:name => name)
            season.should_not have(1).error_on(:name)
          end.should change(Season, :count)
      	end
      end      
    end
    
    describe "should disallows illegitimate rounds_count:" do
      [-1, '2.5', 'abc', '2a', 31].each do |rounds_count|
      	it "'#{rounds_count}'" do
      	  lambda do
            season = create_season(:rounds_count => rounds_count)
            season.should have(1).error_on(:rounds_count)
          end.should_not change(Season, :count)
      	end
      end      
    end
    
    describe "should disallows illegitimate questions_count:" do
      [-1, '2.5', 'abc', '2a', 31].each do |questions_count|
      	it "'#{questions_count}'" do
      	  lambda do
            season = create_season(:questions_count => questions_count)
            season.should have(1).error_on(:questions_count)
          end.should_not change(Season, :count)
      	end
      end      
    end    
  end
  
  describe 'when created' do
    it "should create new season" do          
      lambda do
        create_season  
      end.should change(Season, :count)
    end  
  
    it 'should create :rounds_count rounds' do 
      season = create_season
      season.should have(@params[:rounds_count]).rounds            
    end 
    
    it 'should create :questions_count questions in each round' do 
      season = create_season
      season.rounds.each do |round| 
        round.should have(@params[:questions_count]).questions 
      end 
    end 
  end 
  
  it "should not destroy if have published round" do
    season = create_season
    season.rounds[0].update_attribute(:published, true)
    season.reload
    lambda do
       season.destroy         
    end.should_not change(Season, :count)
  end

  it "should destroy if not have published round" do
    season = create_season      
    lambda do
      season.destroy         
    end.should change(Season, :count)
  end

end
