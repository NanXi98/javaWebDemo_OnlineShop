package com.shopping.service;

import com.shopping.dao.ReplyDao;
import com.shopping.entity.Reply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ReplyServiceImplement implements ReplyService{
    @Autowired
    private ReplyDao replyDao;
    @Override
    public List<Reply> getReplyByPostId(int postId)
    {
        return replyDao.getReplyByPostId(postId);
    }
    @Override
    public void addReply(Reply reply)
    {
        replyDao.addReply(reply);
    }
    @Override
    public List<Reply> getReplyByUserId(int userId){return replyDao.getReplyByUserId(userId);}
    @Override
    public boolean deleteReplyByReplyId(int replyId){return  replyDao.deleteReplyByReplyId(replyId);}
    @Override
    public List<Reply> getAllReply(){return replyDao.getAllReply();};

}
