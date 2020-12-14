package com.shopping.entity;

import javax.persistence.*;


@Entity
@Table(name="shopping_car")
@IdClass(value=ShoppingCarPriKey.class)
public class ShoppingCar {
    private int userId;
    private int productId;
    private double productPrice;
    private int counts;

    @Id
    @Column(name="user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Id
    @Column(name="product_id")
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    @Column(name="product_price")
    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    @Column(name="counts")
    public int getCounts() {
        return counts;
    }

    public void setCounts(int counts) {
        this.counts = counts;
    }
}
