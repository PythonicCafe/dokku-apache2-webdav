# Dokku webdav

This image can be used to run docker container in dokku PaaS without code
modification.

The webdav server is serving the /data paths so the url should be similar to
http://localhost:5000/data

USERNAME and PASSWORD env vars can be used to set the needed authentication.

Remember to mount the container dir `/app/data` outside the container for
persistence.

Here and example of configuration:

```shell
# Set these variables
APP=my-app-name
APP_DOMAIN=my-app.example.com
USERNAME=my-user
PASSWORD=my-secret

# Create app, mount storage and set user/pass
dokku apps:create $APP
dokku storage:mount $APP /var/lib/dokku/data/storage/$APP:/app/data
dokku config:set --no-restart $APP USERNAME=$USERNAME
dokku config:set --no-restart $APP PASSWORD=$PASSWORD
dokku domains:add $APP $APP_DOMAIN
```

Now, deploy your app from your local machine:

```shell
git clone <this-repo's-url>
cd dokku-webdav
git remote add dokku dokku@<my-host>:<my-app-name>
git push dokku master
```

Finally, back on server:

```shell
dokku letsencrypt:enable $APP
```
> Note: before enabling Let's Encrypt on this app you may need to run
> `dokku config:set $APP DOKKU_LETSENCRYPT_EMAIL=you@example.com`.
