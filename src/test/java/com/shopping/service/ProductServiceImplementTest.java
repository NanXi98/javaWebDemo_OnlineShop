package com.shopping.service;

import com.shopping.entity.Product;
import org.junit.Test;

import static org.junit.Assert.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class ProductServiceImplementTest {
    @Autowired ProductService productService;
    @Test
    public void getProductsByType() {
        List<Product> list = productService.getProductsByType(1);
        System.out.println(list.toString());

    }
}