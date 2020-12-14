package com.shopping.service;

import com.shopping.entity.Post;


import java.util.List;

public interface PostService {

    public List<Post> getPostByProductId(int productId);
    public void addPost(Post post);
    public Post getPostByPostId(int postId);
    public List<Post> getPostByUserId(int userId);
    public boolean deletePostByPostId(int postId);
    public List<Post> getAllPost();
}
