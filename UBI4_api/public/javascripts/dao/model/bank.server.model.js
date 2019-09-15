
var mongoose = require('mongoose');

var BankSchema = new mongoose.Schema({
    owner: String,
    totalIssuedScore: Number,
    totalSettledScore: Number
});

mongoose.model('Bank', BankSchema);