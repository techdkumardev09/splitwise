# Rails Assignment - Splitwise

## Setup
- Fork the repository.
- Clone the repository in your local machine.
- Run `rails db:setup`, this will also seed data in the `User` model
- Run `rails s` to start the server and `rails c` for rails console

## Requirements

- Ruby - 2.6.3
- Rails - 6.1.4
- Git (configured with your Github account)
- Node - 12.13.1


## Things available in the repo
- Webpacker configured and following packages are added and working.
  - Jquery
  - Bootstrap
  - Jgrowl
- Devise installed and `User` model is added. Sign in and Sign up pages have been setup.
- Routes and layouts for following page have been added.
  - Dashboard - This will be the root page.
  - Friend page - `/people/:id`


## Submission
- Make the improvements as specified in your technical assignment task.
- Commit all changes to the fork you created
- Deploy your app to Heroku
- Send us the link of the dpeloyed application and your fork.


## Feature Added
  1. Expense Creation:
    - Users can create expenses by providing details such as amount, description, and participants etc.
    - Expenses can be split equally or unequally among participants.

  2. Expense Viewing:
    - Users can view expenses created by themselves and their friends.
    - Detailed information about each expense, including amount, description, and participants, is displayed.

  3. Balance Management:
    - Total Balance: Users can check their total balance, which reflects the net amount they owe or are owed
      by all friends.

  4. Owed Balances:
    - Users can check the total amount they owe.
    - Users can check the total amount owed to them by friends.

  5. Friend Management:
    - Users can list their friends who are part of the expense-sharing network.

## Note:
    Due to time constraints, some features outlined in this task may have been missed in the initial implementation. However, rest assured that the core functionality described has been achieved, allowing users to create expenses, view them, manage balances, and interact with friends within the app.

## Contact us
If you need any help regarding this assignment or want to join [Commutatus](https://www.commutatus.com/), drop us an email at work@commutatus.com
