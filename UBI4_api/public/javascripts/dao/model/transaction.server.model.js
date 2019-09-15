
var mongoose = require('mongoose');

var TransactionSchema = new mongoose.Schema({
    txHash: String,
    txType: Number,
    sender: String,
    receiver: String,
    score: Number
});

mongoose.model('Transaction', TransactionSchema);