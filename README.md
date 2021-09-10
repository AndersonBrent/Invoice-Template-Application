# Invoice

SETUP -

  requirements: GIT, Node.js
  
  Step 1). Download and install the requirements if you don't already have them.
  
  Step 2). Open up GIT wherever you would like to clone the project by simply right clicking and selecting "Git Bash Here" and run this command: ```git clone https://github.com/ICS-370/Invoice-Template-Application.git``` to get a copy of the repository.
  
  Steo 3). After the project is cloned, make sure all of the dependencies are installed by running: ```npm i``` and this will create a "node_modules" folder at the root of the project.
  
  Step 4). Once you have all of the project dependencies you'll be able to run: ```npm run start``` to get a local server running with react. It usually takes a couple seconds and then your browser should automatically open so you can see the project within the browser locally.


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
