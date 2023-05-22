const express = require("express");
const app = express();
require('dotenv').config();

const PORT = process.env.PORT || 3000;

app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use('/api', require('./routes/route.route'));

app.listen(PORT, () => {
    console.log(`listening on port ${PORT}`); 
});




