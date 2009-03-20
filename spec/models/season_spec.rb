require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Season do

  it { should validate_presence_of(:name) } 
  it { should validate_presence_of(:rounds_count)}
  it { should validate_presence_of(:questions_count)}
  
  #it { should validate_length_of(:name, :maximum => 100)}
   
  it { should validate_numericality_of(:rounds_count) }
  it { should validate_numericality_of(:questions_count) }
  
  it { should have_many(:rounds)}
      
  it "should factory" do
    season = Factory(:season)                                                    
    season.should_not be_nil
    season.should be_valid
  end                     
                               
  describe 'when created' do
    it "should create new season" do          
      lambda do
        Factory(:season)        
      end.should change(Season, :count)
    end  
  
    it 'should create :rounds_count rounds' do 
      season = Factory(:season)      
      season.should have(Factory.attributes_for(:season)[:rounds_count]).rounds            
    end 
    
    it 'should create :questions_count questions in each round' do 
      season = Factory(:season)
      season.rounds.each do |round| 
        round.should have(Factory(:season)[:questions_count]).questions 
      end 
    end 
  end   

end
