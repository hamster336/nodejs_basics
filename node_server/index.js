import express, { json, urlencoded } from 'express';
// const express = require('express');

const app = express();

app.use(json());

app.use(urlencoded({
    extended: true
}));

const productData = [];

app.listen(2000, () => {
    console.log('Connected to server at port 2000')
})


// post api
app.post("/api/add_product", (req, res) => {
    console.log("Result", req.body);

    const pdata = {
        "id" : Math.random().toString(36).slice(-8),
        "pname" : req.body.pname,
        "pprice": req.body.pprice,
        "pdesc" : req.body.pdesc
    };

    productData.push(pdata);
    console.log("Final", pdata);

    res.status(200).send({
        "status_code": 200,
        "message": "Product added successfully",
        "product": pdata
    });
});

// get api
app.get("/api/get_product", (req, res) => {
    if(productData.length > 0) {
        res.status(200).send({
            'status_code': 200,
            'products': productData
        });
    }else{ 
        res.status(200).send({
            'status_code': 200,
            'products': []
        });
    }
});

// update api
// update can be done by two methods:
// put -> replace the entire object
// patch -> replace partially

app.put("/api/update:id", (req, res) => {
    let id = req.params.id;
    let productToUpdate = productData.find(p => p.id === id);
    let index = productData.indexOf(productToUpdate);

    productData[index] = req.body;

    res.status(200).send({
        'status_code': 200,
        'message': 'Produc updated'
    });
})