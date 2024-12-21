package com.secor.product;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "prodid")
    private Long prodid;
    @Column(name = "prodname")
    private String prodname;
    @Column(name = "proddescription")
    private String proddescription;
    @Column(name = "prodprice")
    private BigDecimal prodprice;
    @Column(name = "prodstockQuantity")
    private int prodstockQuantity;

    public int getProdstockQuantity() {
        return prodstockQuantity;
    }

    public void setProdstockQuantity(int prodstockQuantity) {
        this.prodstockQuantity = prodstockQuantity;
    }

    public BigDecimal getProdprice() {
        return prodprice;
    }

    public void setProdprice(BigDecimal prodprice) {
        this.prodprice = prodprice;
    }

    public String getProddescription() {
        return proddescription;
    }

    public void setProddescription(String proddescription) {
        this.proddescription = proddescription;
    }

    public String getProdname() {
        return prodname;
    }

    public void setProdname(String prodname) {
        this.prodname = prodname;
    }

    public Long getProdid() {
        return prodid;
    }

    public void setProdid(Long prodid) {
        this.prodid = prodid;
    }


}
