dan-t.de
========

This is my private home page. I created it as a project to learn Rails.

If you are a Rails beginner, feel free to copy any features you like. I tried to stick to Rails best practices, so take this as an example of how things can be done in Rails.

If you are a Rails pro and for whatever reason read my code, please let me know what you would have done differently.

Installation
============

Deployment is done using Capistrano. Check out the GitHub repo and update the ./config/deploy.rb with the paths for your deployment. 

On first deploy you have to create a database.yml (compare to database.exampe.yml) file containing your DB configuration and place in in the shared folder of the deployment.

To set an admin password visit [domian]/password/new .

To keep the secret\_token and the password constant for the next deployments, move the .secret and .admin\_password from the apps config folder to ../../shared/config.
