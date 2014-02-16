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
  
  def leaderboard_hash
    ActiveRecord::Base.connection.execute('SELECT COUNT("behaviors"."user_id") AS count_user_id, user_id AS user_id, users.first_name, users.last_name FROM "behaviors" INNER JOIN "users" ON "users"."id" = "behaviors"."user_id" GROUP BY user_id, users.first_name, users.last_name ORDER BY "behaviors"."count" DESC')
  end



end

