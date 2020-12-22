# Smartlinks

Smartlinks is a simple application intended for creating and navigating so called "smartlinks".

Navigating looks like this:
1. a user runs the application,
2. on the start page all existing smartlinks are listed, where "smartlink" is a combination of URL, language and slug (an alias for the URL),
2. in the address bar of the browser the user adds to the base application address a line like '/smartlinks/panda', where "panda" is an example of a slug.
3. if such slug exists in the application and a smartlink for this slug and the browser language is defined, redirection to that smartlink URL happens,
4. if there is no smartlink for the browser language, redirection to the smartlink URL with the default language happens, which is English,
5. if there is no smartlink with the default language or a smartlink with such slug doesn't exist, an according message shows up.
 
The user also can create and delete smartlinks. For that he/she must log in into the system, Log in button can be found on the start page.

# Technical details
* Programming language: Ruby 2.7.1,
* Framework: Rails 6.0.3.4
* DBMS: PostgreSQL
* ORM Framework: ActiveRecord
* Testing tool: Rspec

# How to run the app
1. Clone the repository from GitHub / extract it from the archive.
2. Navigate to the app folder.
3. Make sure PostgreSQL, Ruby 2.7.1 and the package manager Yarn are installed on your machine.
4. Run in the command line 'bundle install'.
5. Run 'yarn install'
6. If encounter some problems during step 5 and 6, follow the instruction from the output in the command line.
7. Open the file '.../config/database.yml' and put there a real DB username existing on your machine.
8. Run 'rails db:create'.
9. Run 'rails db:migrate'.
10. Run 'rails server'
