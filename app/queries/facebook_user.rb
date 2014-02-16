class FacebookUser
  def initialize(userapp_token) 
    @api=UserApp::API.new(token: userapp_token)
  end 

  def get_feed 
    graph_result =@api.oauth.request(provider_id: "facebook", user_id: "self", method: "get", path: "/me/feed")
    if graph_result.status_code = 200
      @data = graph_result.body.data 
    end 
  end 
  # def get_accounts
  #   graph_result =@api.oauth.request(provider_id: "facebook", user_id: "self", method: "get", path: "/me/accounts")
  #   if graph_result.status_code = 200
  #     @data = graph_result.body.data 
  #   end 
    
  # end

  #TODO create User and Page registration controller

  def parse_data
    #TODO: only save if user is in your team

    @data.each do |entry|
      page = find_page(entry)

      post = find_post(entry, page)

      # user_id = Page.where(id: post.page_id).take.user_id
      user_id = page.user_id

      add_likes(entry, post, user_id)

      add_comments(entry, post, user_id)

      add_tag(entry, post, user_id)  
    end
  end

private
  def find_page(entry) 
    unless Page.where(facebook_id: entry.from.id).first 
        Page.create(facebook_id: entry.from.id)      
      end       
    Page.where(facebook_id: entry.from.id).first  
  end

  def find_post(entry, page) 
    unless Post.where(entry_id: entry.id).first
      fb_post_time = Time.parse(entry.created_time)
      Post.create(page_id: page.id, entry_id: entry.id, post_type: entry.type, fb_created_time: fb_post_time)
    end
    Post.where(entry_id: entry.id).first
  end

  def add_tag(entry, post, user_id)
    if entry.message_tags
      entry.message_tags.each_pair do |key, value|
        
        Behavior.create(post_id: post.id, behavior_type: "tag", facebook_id: value[0].id, user_id: user_id)
      end
    end
  end

  def add_likes(entry, post, user_id)
    if entry.likes
      entry.likes.data.each do |user|
        Behavior.create(post_id: post.id, behavior_type: "like", facebook_id: user.id, user_id: user_id )
      end
    end
  end

  def add_comments(entry, post, user_id)
    if entry.comments
      entry.comments.data.each do |user|
        Behavior.create(post_id: post.id, behavior_type: "comment", facebook_id: user.from.id, user_id: user_id )
      end
    end
  end

end


# For the registration controller


  # def new_page(entry)
  #   if post_sent?(entry)
  #     Page.create(type: entry.to.name, user_id: entry.to.id )
  #   else
  #     Page.create(type: entry.to.name, user_id: entry.from.id)
  #   end
  # end