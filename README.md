# README

Edit:
late update, 22/05/2022

I just realized that some of the changes that are visibly approved and merged as PRs weren't actually merged with the main (it's sill puzzling my head, idk why it happened, I'll investigate it later), so I manually merged them as commits to main.


I had some trouble deploying to heroku. It's still giving me some errors. I couldn't get much work done about it due to some exams, but I'll try to redo the deploy during the week, even if it won't count towards the project qualifications.



About the project: working fine in my environment. I think I only have one MVP feature missing from [ticket 6](https://trello.com/c/biTQls7h/26-rslc-6-as-a-user-i-should-be-able-to-see-all-my-conversations) where in the apiary example a conversation should be returned with a value for "unread_messages" and "last_message". tbh, I just forgot to implement those. The implementation I thought for "unread_messages" was creating a column and scope for users to store their last active session as a datetime, and for every message received with a date larger than the last active session, it would sum one to a "unread_messages" variable.



Was having some trouble with simplecov that made me waste a lot of time. It was randomly returning as "non-covered" some model specs that were totally valid. Wrote tests and referred to simplecov and rspec docs a dozen times, until I found the problem: simplecov wasn't initialized at the very top of rails_helper. Working fine with a 100% coverage now (excluded some files that shouldn't be tested in the first place).


## How to use Docker

### Install Docker
- Download it at https://www.docker.com/products/docker-desktop

### Useful commands

- `docker-compose up --build` to run app locally at http://localhost:3000
- `docker compose run --rm test rspec` to run tests
- `docker compose run --rm development rake code_analysis` to run code analysis tools
- `docker compose run --rm development bundle install` to install gems
- `docker compose down -v` to delete all Docker containers and volumes
