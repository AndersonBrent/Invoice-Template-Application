const appData = require('./data/app.json');
var users = [];
const express = require('express');
const app = express();
const mysql = require('mysql');
const port = 5001;

var connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "invoice"
});

connection.connect((err) => {
  if (err) {
    throw err;
  }
  console.log("Connection successful!");
})

//get users
connection.query('SELECT id AS "userID", username AS "user", password AS "pass", name, email, phone FROM `users`;', function (err, rows, fields) {
  if (err) {
    throw err;
  }

  rows.forEach((row) => {
    users.push({
      userID: row.userID,
      user: row.user,
      pass: row.pass,
      personalInfo: {
        name: row.name,
        address: "", //TO DO (or not)
        email: row.email,
        phone: row.phone
      },
      invoices: [],
    });
  })
});

//invoices & items
users.forEach((user) => {
  //INVOICES
  connection.query('SELECT invoices.id AS "invoiceID", invoices.client_id AS "clientID", billing_date AS "date", clients.name AS "toName", clients.email AS "toEmail", users.name AS "fromName", users.email AS "fromEmail", users.phone AS "fromPhone", clients.addr_street AS "toStreet", clients.addr_city AS "toCity", clients.addr_state AS "toState", clients.phone AS "toPhone", invoices.charge AS "amountBilled" FROM `invoices`, `clients`, `users` WHERE users.id = ' + user.userID + ' AND invoices.user_id = users.id AND clients.id = invoices.client_id;', function (err, rows, fields) {
    if (err) {
      throw err;
    }

    rows.forEach((row) => {
      user.invoices.push({
        invoiceID: row.invoiceID,
        invoiceName: "",
        clientID: row.clientID,
        fromName: row.fromName,
        fromAddress: {
          street: "",
          cityState: "",
          zip: ""
        },
        fromPhone: row.fromPhone,
        toName: row.toName,
        toEmail: row.toEmail,
        toAddress: {
          street: row.toStreet,
          cityState: row.toCity + ", " + row.toState,
          zip: ""
        },
        toPhone: row.toPhone,
        date: row.date,
        amountBilled: row.amountBilled,
        balanceDue: row.amountBilled,
        items: []
      });
    })
  });

  //ITEMS
  connection.query('SELECT items.description, items.rate, items.quantity AS "qty", items.tax, items.note AS "additionalDetails" FROM `items` JOIN `clients`, `users` WHERE users.id = ' + user.userID + ' AND clients.user_id = users.id AND items.client_id = clients.id', function (err, rows, fields) {
    if (err) {
      throw err;
    }

    rows.forEach((row, i) => {
      user.invoices.items.push({
        description: row.description,
        rate: row.rate,
        qty: row.quantity,
        tax: row.tax,
        additionalDetails: row.note
      });
    })
  });
})

const data = {
  app: appData,
  users: users
}

app.get('/data', (req, resp) => {
  resp.send(data);
});

app.listen(port, () => {
  console.log('Example app listening on port: ', port);
});
