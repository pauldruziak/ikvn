module SeasonsHelper  
  
  def seasons
  	seasons = Season.find(:all, :order => "id DESC")
  	signed_in_as_admin? ? seasons : seasons.select do |season| season.published? 	end
  end
end
