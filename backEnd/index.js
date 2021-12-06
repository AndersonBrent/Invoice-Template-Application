const appData = require('./data/app.json');
var users = [];
var data = {};
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
  init();
});

function init() {
  users = [];
  let user = false, invoice = false, item = false, data = false;
  console.log("init()");

  fetchUsers();

  setTimeout(function () {
    fetchInvoices();
    user = true;
    invoice = true;
  }, 1000);

  setTimeout(function () {
    fetchItems();
    item = true;
  }, 2000);

  setTimeout(function () {
    configureData();
    data = true;
  }, 4000);

  setTimeout(function () {
    if (!(user, invoice, item, data)) {
      throw Error("Data fetch from DB didn't work out dawg");
    }
    else {
      console.log("Everything is working somehow...");
    }
  }, 6000);
}

function fetchUsers() {
  console.log("fetchUsers()");
  //get users
  connection.query('SELECT id AS "userID", username AS "user", password AS "pass", name, email, phone FROM `users`;', function (err, rows, fields) {
    console.log("fetchUsers(): # of users results from DB: " + rows.length);
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
    console.log("fetchUsers(): # of users stored locally: " + users.length);
  });
}

function fetchInvoices() {
  console.log("fetchInvoices()");
  //invoices & items
  console.log("fetchInvoices(): Length of users: " + users.length);
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
          fromEmail: row.fromEmail,
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
    console.log("user= " + JSON.stringify(user));
  });
}

function fetchItems() {
  console.log("fetchItems()");
  //ITEMS
  users.forEach((user) => {
    console.log("userid: " + user.userID);
    if (user.invoices.length == 0) {
      console.log("Invoices not loaded!");
    }
    else {
      console.log("Invoices loaded!");
    }
    user.invoices.forEach((invoice, j) => {
      let queryStr = `SELECT items.description, items.rate, items.quantity AS "qty", items.tax, items.note AS "additionalDetails" FROM items JOIN \`invoices\` WHERE invoices.user_id = ${user.userID} AND items.invoice_id = invoices.id`;
      connection.query(queryStr, function (err, rows, fields) {
        console.log("fetchItems(): queryStr= " + queryStr);
        console.log("fetchItems(): numberOfItems= " + rows.length);
        if (err) {
          throw err;
        }

        rows.forEach((row) => {
          invoice.items.push({
            description: row.description,
            rate: row.rate,
            qty: row.quantity,
            tax: row.tax,
            additionalDetails: row.note
          });
        })
      });
    });
  });
}

function configureData() {
  console.log("configureData()");
  data = {
    app: appData,
    users: users
  }
};

app.get('/data', (req, resp) => {
  resp.send(data);
});

app.listen(port, () => {
  console.log('Example app listening on port: ', port);
});
