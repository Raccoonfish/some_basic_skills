#!/bin/bash

#install postgres
sudo mkdir -p /etc/apt/keyrings
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg
echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
apt-get update

postgresql_version=18
apt install postgresql-$postgresql_version postgresql-client-$postgresql_version -y

#check_psql
systemctl enable postgresql
systemctl start postgresql
systemctl status postgresql

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'P@ssw0rd';"
sudo -u postgres createuser john
sudo -u postgres createdb johndb
sudo -u postgres psql -c "ALTER USER john WITH ENCRYPTED PASSWORD 'XtkWtyZltVtl';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE johndb TO john;"
sudo -u postgres psql -c "GRANT ALL ON SCHEMA public TO john;"

#RAM and lan_login opening
targ_version="18"

for version in /etc/postgresql/*/

do dir_name=$(basename "$version")

    if [ "$dir_name" == "$targ_version" ]; then

  echo $version
  cd $version/main/
  sed -i 's/shared_buffers = 128MB/shared_buffers = 700MB/' postgresql.conf
  sed -i 's|#listen_addresses = '\''localhost'\''|listen_addresses = '\''*'\''|' postgresql.conf
  cd $version/main/
  sed -i 's|local   all             all                                     peer|local   all             all                                     md5|' pg_hba.conf
  sed -i 's|host    all             all             127.0.0.1/32            scram-sha-256|host    all             all             192.168.108.0/22            scram-sha-256|' pg_hba.conf
    fi  
done
systemctl restart postgresql