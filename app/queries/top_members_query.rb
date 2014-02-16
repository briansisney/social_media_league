class TopMembersQuery


  def post_count_per_page(page_id)
    Post.where(page_id: page_id).count
  end
   
  def count_per_type
    Post.group(:post_type).select(:post_type).count
  end
  
  def count_per_post_id
    #post Id can be subsituted with user.id
    Behavior.group(:post_id).select(:post_id).order(count: :desc).count
  end
  
  def top_post_this_week
    #we dont record the picture or comment so it just gives us an id
    tophash = Behavior.group(:post_id).select(:post_id).order(count: :desc).limit(1).count
    Post.where(id: tophash.keys.first)
  end
  
  

end