package com.shopping.service;

import com.shopping.entity.Reply;

import java.util.List;

public interface ReplyService {
    public List<Reply> getReplyByPostId(int postId);
    public void addReply(Reply reply);
    public List<Reply> getReplyByUserId(int userId);
    public boolean deleteReplyByReplyId(int replyId);
    public List<Reply> getAllReply();
}
