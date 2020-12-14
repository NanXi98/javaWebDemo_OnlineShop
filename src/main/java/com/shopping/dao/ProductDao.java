package com.shopping.dao;

import com.shopping.entity.PageBean;
import com.shopping.entity.Product;

import java.util.List;


public interface ProductDao {
    public Product getProduct(int id);

    public Product getProduct(String name);

    public void addProduct(Product product);

    public boolean deleteProduct(int id);

    public boolean updateProduct(Product product);

    public List<Product> getProductsByKeyWord(String searchKeyWord, String selected);

    public List<Product> getProductsByType(int type);

    public PageBean<Product> findByPageProduct (int type, int pageNum, int pageSize);

    public List<Product> getAllProduct();

    public List<Product> getProductByUserId(int userId);

    public boolean deleteProductByOwnerId(int id);

    public int getUserIdbyProductId(int ProductId);

    public List<Long> getProductNum();

}
