package com.shopping.service;

import com.shopping.dao.CommentDao;
import com.shopping.dao.ProductDao;
import com.shopping.dao.ShoppingCarDao;
import com.shopping.dao.ShoppingRecordDao;
import com.shopping.dao.UserDao;
import com.shopping.entity.PageBean;
import com.shopping.entity.Product;
import com.shopping.entity.User;
import com.shopping.utils.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;



@Service
public class ProductServiceImplement implements ProductService {
    @Autowired
    private ProductDao productDao;
    @Autowired
    private ShoppingRecordDao shoppingRecordDao;
    @Autowired
    private ShoppingCarDao shoppingCarDao;
    @Autowired
    private CommentDao CommentDao;
    @Autowired
    private UserDao userDao;

    @Override
    public Product getProduct(int id) {
        return productDao.getProduct(id);
    }

    @Override
    public Product getProduct(String name) {
        return productDao.getProduct(name);
    }

    @Override
    public int addProduct(Product product) {
        productDao.addProduct(product);
        return product.getId();
    }

    @Override
    @Transactional
    public Response deleteProduct(int id) {
        try {
            CommentDao.deleteCommentByProduct(id);
            shoppingCarDao.deleteShoppingCarByProduct(id);
            shoppingRecordDao.deleteShoppingRecordByProductId(id);
            productDao.deleteProduct(id);
            return new Response(1, "删除商品成功", null);
        }catch (Exception e){
            return new Response(0,"删除商品失败",null);
        }
    }

    @Override
    public boolean updateProduct(Product product) {
        return productDao.updateProduct(product);
    }


    @Override

    public List<Product> getProductsByKeyWord(String searchKeyWord, String selected) {

        return productDao.getProductsByKeyWord(searchKeyWord, selected);

    }


    @Override
    public List<Product> getProductsByType(int type) {
        return productDao.getProductsByType(type);
    }

    @Override
    public List<Product> getAllProduct() {
        return productDao.getAllProduct();
    }

    @Override
    public List<Product> getProductByUserId(int userId){
        return productDao.getProductByUserId(userId);
    }

    @Override
    public User getOwnerByProductId(int ProductId){
        int userId=productDao.getUserIdbyProductId(ProductId);
        return userDao.getUser(userId);
    }

    @Override
    public PageBean<Product> findByPage(int type, int pageNum, int pageSize) {
        PageBean<Product> pageResult = productDao.findByPageProduct(type, pageNum, pageSize);
        return pageResult;
    }

    @Override
    public List<Long> getProductNumber() {
        return productDao.getProductNum();
    }

}
