



json.user do 

   

    json.slug @user.slug
    json.name @user.name
    json.total_projects @user.projects.size
    json.total_anticipations @user.anticipations.size
    json.total_suggestions @user.suggestions.size
    json.repu_coin @user.repu_coin
    json.about @user.about
    json.is_following current_api_v1_user.following?(@user) if current_api_v1_user.id != @user.id
    json.expired_anticipation @expired_anticipation
    json.image @user.image
    json.website_url @user.website_url 
    json.github_url @user.github_url 
    json.linkedin_url @user.linkedin_url 
    json.total_project_votes @total_project_votes
    json.total_followers @user.followers_by_type_count('User')
    json.total_followings @user.following_by_type_count('User')
    json.backcover_imgurl @user.backcover_imgurl
    json.avatar_url @user.avatar_url




end