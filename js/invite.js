'use strict';

var AWS = require('aws-sdk');
var DOC = require('dynamodb-doc');
AWS.config.update({region: 'us-east-2'});
var dynamo = new DOC.DynamoDB();

var params = {
  TableName: 'Invites',
  Item: {
    'InviteId' : '1',
    'Email' : 'domain@example.com',
  }
};

exports.handler = function (event, context, callback) {
    var response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'text/html; charset=utf-8',
        },
        body: "<p>------Hello world!!---</p>",
    };
    dynamo.putItem(params, function(err, data) {
        if (err) {
          console.log("Error", err);
        } else {
          console.log("Success", data);
        }
    });
    callback(null, response);
};
