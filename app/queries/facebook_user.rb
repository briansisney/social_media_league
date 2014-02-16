class FacebookUser
  def initialize(userapp_token) 
    @api=UserApp::API.new(token: userapp_token)
  end 

  def get_feed 
    graph_result =@api.oauth.request(provider_id: "facebook", user_id: "self", method: "get", path: "/me/feed")
    if graph_result.status_code = 200
      @data = graph_result.body.data 
      binding.pry
    end 
  end 

  #TODO create User and Page registration controller

  def parse_data
    #TODO: need to validate that there are only one entry

    #TODO: only save if user is in your team

    @data.each do |entry|
      page = find_page(entry)
      
      post = Post.where(entry_id: entry.id)
      unless post
        post = Post.create(page_id: page, entry_id: entry.id, type: entry.type)
      end 

      add_likes(entry, post)

      add_comments(entry, post)

      add_tag(entry, post)
      
    end

  end

#when join, create page.


private
  def find_page(entry) 
      Page.where(user_id: entry.from.id)    
  end

  def add_tag(entry, post)
    if entry.message_tags
      entry.message_tags.each_pair do |key, value|
        Behavior.create(post_id: post, type: "tag", facebook_id: value[0].id )
      end
    end
  end

  def add_likes(entry, post)
    if entry.likes
      entry.likes.data.each do |user|
        Behavior.create(post_id: post, type: "like", facebook_id: user.id )
      end
    end
  end

  def add_comments(entry, post)
    if entry.comments
      entry.comments.data.each do |user|
        Behavior.create(post_id: post, type: "comment", facebook_id: user.from.id )
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