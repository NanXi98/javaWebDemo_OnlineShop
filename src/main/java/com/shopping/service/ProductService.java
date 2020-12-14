package com.shopping.service;

import com.shopping.entity.PageBean;
import com.shopping.entity.Product;
import com.shopping.entity.User;
import com.shopping.utils.Response;

import java.util.List;


public interface ProductService {
    public Product getProduct(int id);

    public Product getProduct(String name);

    public int  addProduct(Product product);

    Response deleteProduct(int id);

    public boolean updateProduct(Product product);

    public List<Product> getProductsByKeyWord(String searchKeyWord,String selected);


    public List<Product> getProductsByType(int type);

    public List<Product> getAllProduct();

    public List<Product> getProductByUserId(int userId);

    public User getOwnerByProductId(int ProductId);

    public PageBean<Product> findByPage(int type, int pageNum, int pageSize);

    public List<Long> getProductNumber();

}
