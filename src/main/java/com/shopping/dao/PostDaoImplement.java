package com.shopping.dao;

import com.shopping.entity.Post;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.List;

@Repository
public class PostDaoImplement implements PostDao {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public List<Post> getPostByProductId(int productId){
        String hql = "from Post where product_id= ?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0,productId);
        return query.list();
    }

    @Override
    public List<Post> getPostByUserId(int userId){
        String hql = "from Post where user_id= ?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0,userId);
        return query.list();
    }

    @Override
    public void addPost(Post post){
        sessionFactory.getCurrentSession().save(post);
    }

    @Override
    public Post getPostByPostId(int postId){
        String hql = "from Post where id=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0, postId);
        return (Post) query.uniqueResult();
    }
    @Override
    public boolean deletePostByPostId(int postId)
    {
        String hql = "delete Post where id=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0, postId);
        return query.executeUpdate() > 0;
    }

    @Override
    public List<Post> getAllPost()
    {
        String hql = "from Post";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        return query.list();
    }
}
