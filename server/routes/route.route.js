const express = require('express');
const route = express.Router();
const ChatTokenBuilder = require("../src/ChatTokenBuilder").ChatTokenBuilder;

const appId = process.env.APP_ID;
const appCertificate = process.env.APP_CERTIFICATE;
const expirationInSeconds = 3600;

route.get('/v1/user-token/:userID', (req, res, next) => {
    const userUuid = req.params.userID;
    const userToken = ChatTokenBuilder.buildUserToken(appId, appCertificate, userUuid, expirationInSeconds);
    console.log("Chat User Token: " + userToken + "\n");
    res.status(200).json({ 'token': userToken })
});

route.get('/v1/appToken/', (req, res, next) => {
    const appToken = ChatTokenBuilder.buildAppToken(appId, appCertificate, expirationInSeconds)
    console.log("Chat App Token: " + appToken);
    res.status(200).json({ token: appToken })
});

module.exports = route;