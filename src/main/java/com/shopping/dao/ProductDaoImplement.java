package com.shopping.dao;

import com.shopping.entity.PageBean;
import com.shopping.entity.Product;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


@Repository
public class ProductDaoImplement implements ProductDao {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public Product getProduct(int id) {
        String hql = "from Product where id=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0, id);
        return (Product) query.uniqueResult();
    }

    @Override
    public Product getProduct(String name) {
        String hql = "from Product where name=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0,name);
        return (Product) query.uniqueResult();
    }

    @Override
    public void addProduct(Product product) {
        sessionFactory.getCurrentSession().save(product);
    }

    @Override
    public boolean deleteProduct(int id) {
        String hql = "delete Product where id=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0, id);
        return query.executeUpdate() > 0;
    }

    @Override
    public boolean updateProduct(Product product) {
        String hql = "update Product set name=?,description=?,keyWord=?,price=?,counts=?,type=? where id=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0,product.getName());
        query.setParameter(1,product.getDescription());
        query.setParameter(2,product.getKeyWord());
        query.setParameter(3,product.getPrice());
        query.setParameter(4,product.getCounts());
        query.setParameter(5,product.getType());
        query.setParameter(6,product.getId());
        return query.executeUpdate() > 0;
    }


    @Override
    public List<Product> getProductsByKeyWord(String searchKeyWord, String selected) {

        String queryKeyWord = "%";

        for(int i=0;i<searchKeyWord.length();i++){

            queryKeyWord += String.valueOf(searchKeyWord.charAt(i)) +"%";

        }

        String hql = "from Product where name like ? or keyWord like ? ";

        Query query = sessionFactory.getCurrentSession().createQuery(hql);

        query.setParameter(0, queryKeyWord);

        query.setParameter(1, queryKeyWord);

        System.out.println("我搜索了"+queryKeyWord+"并排序"+selected);

        if(selected.equals("default")) {

            return query.list();

        }

        else if(selected.equals("up")){

            hql = "from Product where name like ? or keyWord like ? order by price asc";

            query = sessionFactory.getCurrentSession().createQuery(hql);

            query.setParameter(0, queryKeyWord);

            query.setParameter(1, queryKeyWord);

            return query.list();

        }

        else{

            hql = "from Product where name like ? or keyWord like ? order by price desc";

            query = sessionFactory.getCurrentSession().createQuery(hql);

            query.setParameter(0, queryKeyWord);

            query.setParameter(1, queryKeyWord);

            return query.list();

        }

    }

    @Override
    public List<Product> getProductsByType(int type) {
        String hql = "from Product where type=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0,type);
        return query.list();
    }


    @Override
    public List<Product> getAllProduct() {
        String hql = "from Product";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        return query.list();
    }

    @Override
    public List<Product> getProductByUserId(int userId){
        String hql = "from Product where userId=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0,userId);
        return query.list();
    }

    @Override
    public boolean deleteProductByOwnerId(int id){
        String hql = "delete Product where userId=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0, id);
        return query.executeUpdate() > 0;
    }
    public int getUserIdbyProductId(int ProductId){
        String hql = "from Product where id=?";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameter(0, ProductId);
        return ((Product) (query.uniqueResult())).getUserId();
    }
    @Override
    public PageBean<Product> findByPageProduct(int type, int pageNum, int pageSize) {
        String hql = "from Product where type=?";
        Query hqlQuery = sessionFactory.getCurrentSession().createQuery(hql);
        Query countHqlQuery = sessionFactory.getCurrentSession().createQuery(hql);
        // 起始索引
        int fromIndex = pageSize * (pageNum - 1);
        // 从第几条记录开始查询
        hqlQuery.setFirstResult(fromIndex);
        // 一共查询多少条记录
        hqlQuery.setMaxResults(pageSize);
        // 存放所有查询出的商品对象
        List<Product> productList = new ArrayList<Product>();
        // 获取查询的结果
        hqlQuery.setParameter(0, type);
        countHqlQuery.setParameter(0, type);
        productList = hqlQuery.list();
        // 获取总记录数
        List<?> countResult = countHqlQuery.list();
        int totalRecord = countResult.size();
        // 获取总页数
        int totalPage = totalRecord / pageSize;
        if (totalRecord % pageSize != 0) {
            totalPage++;
        }
        PageBean pageResult = new PageBean(pageSize, pageNum, totalRecord, totalPage, productList);
        return pageResult;
    }

    @Override
    public List<Long> getProductNum() {
        String hql = "select count(*) from Product group by type";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        List<Long> list = query.list();
        return list;
    }

}
