const express = require('express');
const app = express();
const port = 5001;

const users = require('./data/users.json');
const appData = require('./data/app.json');

const data = {
  app: appData,
  users: users
}

app.get( '/data', ( req, resp ) => {
  resp.send( data );
} );

app.listen( port, () => {
  console.log( 'Example app listening on port: ', port );
} );
