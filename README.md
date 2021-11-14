# Invoice

REQUIREMENTS - GIT, Node.js ( Ruby: this is needed if you're looking to make style changes )

SETUP -

  Step 1). Download and install the requirements if you don't already have them.

  Step 2). Open up GIT wherever you would like to clone the project by simply right clicking and selecting "Git Bash Here" and run this command: ```git clone https://github.com/ICS-370/Invoice-Template-Application.git``` to get a copy of the repository.

  Step 3). After the project is cloned, make sure all of the dependencies are installed by running: ```npm i``` and this will create a "node_modules" folder at the root of the project ( you need to do this for both the frontend and backend directories specifically ).

  Step 4). Once you have all of the project dependencies installed you'll be able to run: ```node index.js``` from the backend directory to get a backend server initialized. The same will need to be done for the frontend, by running: ```npm start```

  step 5). Anyone looking to see your changes being made, have a 3rd/4th command line open and run: ```npm run sass``` to see your most recent styling changes and ```npm run build``` to see any other content/functional changes being made to the frontend. *Note: any content/functional changes made to the frontend will require the browser to be refreshed --hot reloading hasn't been added to webpack yet.


GOAL - Develop a responsive web application for converting modifiable HTML invoices into a collection for personal use.

INCLUDE:
  - A main landing page for login/registration:

    A). Registration should ask for relevant personal information like: name, email, address, phone #, etc...


  - Once logged in, navigation for:

    A). A collection of invoices.
      1) Button for creating new invoices.
      2) View existing invoices based on client -> invoice #, date, and amount.
        a) Modify/delete clickable invoice from editing pane.

      3) Don't show client if there's no invoices.
      4) Button for toggling All, paid, and unpaid invoices.

    B). A collection of clients.
      1) Add new clients here.        
      2) View existing clients based on name, email, address, and phone.
        a) Modify/delete clickable client from editing pane.

    C). User settings.
      1) Will keep track of personal information set at registration.
      2) Modifiable from this tab.

    D). Logging out.
