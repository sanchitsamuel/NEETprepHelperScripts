# NEETprepHelperScripts

source bin/activate
python3 lib/python3.6/site-packages/pgadmin4/pgAdmin4.py

sudo /etc/init.d/postgresql stop
sudo /etc/init.d/postgresql start

process.env.DATABASE_URL || 'postgres://learner:letmepass@127.0.0.1/learner_development'


ssh -i ~/aws ubuntu@ec2-34-226-19-45.compute-1.amazonaws.com

psql -U shivam -W learner_development -h learner-production.cjuqv7atq8gh.us-west-2.rds.amazonaws.com

_______________________________________________________________________________________________________________

sequelize migration:create --config src/config.json --migrations-path src/migrations --name NAME_OF_MIGRATION

sequelize db:migrate --config src/config.json --migrations-path src/migrations

sequelize db:seed --config src/config.json --seed 20180605154822-addStudySchedule.js --seeders-path src/seeders

-------------------------------------------------------------------------------------------

For anyone that does not wish to completely purge AppArmor.

Check status: sudo aa-status

Shutdown and prevent it from restarting: sudo systemctl disable apparmor.service --now
Unload AppArmor profiles: sudo service apparmor teardown
Check status: sudo aa-status

You should now be able to stop/kill containers.

__________________________________________________________________________

# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)

sudo docker system prune

docker images
docker run -it <IMAGE ID> /bin/bash
cd node_modules/
docker volume rm neetprepbackend_node_modules
docker volume rm neetprepbackend_bower_components
docker build -t registry.gitlab.com/learner.in/learnerwebapi:dev .

_________________________________________________________________________


// deployment to dev server

git checkout develop
git pull
git push gitlab
git tag -a 5.1.19 -m "5.1.19 tag for develop branch"
git push --tags gitlab
