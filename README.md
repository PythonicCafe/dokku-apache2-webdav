# dokku-apache2-webdav

Web app with Dokku-based deployment to expose a server directory through WebDAV

Execute on the server:

```shell
# Change these variables
APP_NAME="myapp"
APP_DOMAIN="myapp.example.com"
ADMIN_EMAIL="admin@example.com"
USERNAME="myuser"
PASSWORD="mysecret"

# Create app, mount storage and set username/password
dokku apps:create "$APP_NAME"
dokku storage:mount "$APP_NAME" /var/lib/dokku/data/storage/$APP_NAME:/app/data
dokku config:set --no-restart "$APP_NAME" "USERNAME=$USERNAME"
dokku config:set --no-restart "$APP_NAME" "PASSWORD=$PASSWORD"
dokku config:set "$APP_NAME" "DOKKU_LETSENCRYPT_EMAIL=$ADMIN_EMAIL"
dokku domains:add "$APP_NAME" "$APP_DOMAIN"
```

Now, deploy your app from your local machine:

```shell
git clone <this-repo's-url>
cd dokku-apache2-webdav
git remote add dokku dokku@<dokku-host>:<myapp>
git push dokku main
```

Finally, back on server:

```shell
dokku letsencrypt:enable $APP
```

Now you can access `https://$APP_DOMAIN/data` using `$USERNAME` and
`$PASSWORD`.
