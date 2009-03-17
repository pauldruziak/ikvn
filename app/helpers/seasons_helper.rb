module SeasonsHelper  
  
  def seasons
  	Season.find(:all, :order => "id DESC")
  end
end
