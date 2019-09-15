

var mongoose = require('mongoose');

var CustomerSchema = new mongoose.Schema({
    customerAddr: String,
    phone: String,
    password: String,
    score: Number,
    buyGoods: [],
    salt: String
});

mongoose.model('Customer', CustomerSchema);