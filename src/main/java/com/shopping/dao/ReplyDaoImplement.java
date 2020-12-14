package com.shopping.dao;

import com.shopping.entity.Reply;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;
@Repository
public class ReplyDaoImplement implements ReplyDao{
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public List<Reply> getReplyByPostId(int postId)
    {
        String hql = "from Reply where Post_id= ?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0,postId);
        return query.list();
    }
    @Override
    public void addReply(Reply reply){
        sessionFactory.getCurrentSession().save(reply);
    };
    @Override
    public List<Reply> getReplyByUserId(int userId){
        String hql = "from Reply where user_id= ?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0,userId);
        return query.list();
    }

    @Override
    public boolean deleteReplyByReplyId(int replyId)
    {
        String hql = "delete Reply where id=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0, replyId);
        return query.executeUpdate() > 0;
    }

    @Override
    public List<Reply> getAllReply()
    {
        String hql = "from Reply";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        return query.list();
    };
}
