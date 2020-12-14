package com.shopping.dao;

import com.shopping.entity.Post;
import org.junit.Test;

import static org.junit.Assert.*;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class PostDaoImplementTest {
    PostDaoImplement postDao = new PostDaoImplement();
    @Test
    public void deletePostByPostId() {
        Post post=postDao.getPostByPostId(7);
        System.out.println(post.toString());
    }
}