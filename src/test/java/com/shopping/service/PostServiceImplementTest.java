package com.shopping.service;

import com.shopping.entity.Post;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class PostServiceImplementTest {
    @Autowired PostService postService;
    @Test
    public void getPostByProductId() {
    }

    @Test
    public void addPost() {
    }

    @Test
    public void getPostByPostId() {
    Post post = postService.getPostByPostId(1);
    System.out.println(post.toString());
    }

    @Test
    public void deletePostByPostId() {
      postService.deletePostByPostId(7);
    }

    @Test
    public void getAllPost()
    {
        List<Post> list = postService.getAllPost();
        System.out.println(list.toString());
    }
}