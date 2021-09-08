# Team 16 project - Speech features software
---

### Description
This is a research software which allows to collect data about to which features of language people pay attention to as they hear it in real time, and then provide listeners with the ability to review their reactions and justify why they reacted.


### Special Development Pre-requisites
ruby '2.6.2'  
rails '6.0.0'  
VPN connection with university network to download gems from 'gems.shefcompsci.org.uk'  

### Running the system / tests
Before starting needs to download the required gems using: `bundle install`   
Run database migrations: `bundle exec rake db:migrate`   
Feed the database with initial data: `bundle exec rake db:seed`   
Start the application: `bundle exec rails s`   

Admin accounts details:  
test@test.com / password  
c.montgomery@sheffield.ac.uk / password  


Run the tests: `bundle exec rspec spec`     

### Deployment
*QA -> Demo -> Production* using the `epi-deploy` gem.


### Customer Contact
Chris Montgomery <c.montgomery@sheffield.ac.uk>
