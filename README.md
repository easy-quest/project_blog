
```bash
tar -C ${HOME}/.local -xzf go1.17.1.linux-amd64.tar.gz
echo "export PATH=$PATH:${HOME}/.local/go/bin" >> ${HOME}/.bashrc;source ${HOME}/.bashrc
echo "export GO111MODULE=on" >> ${HOME}/.bashrc;source ${HOME}/.bashrc
echo "export GOPATH=/home/zzz/go" >> ${HOME}/.bashrc;source ${HOME}/.bashrc
echo "export GOBIN=/home/zzz/go/bin" >> ${HOME}/.bashrc;source ${HOME}/.bashrc
```


---
## GIT

```bash
git config --global user.email easy-quest@mail.ru
git config --global user.name "Ivan Yastrebov"
```
```bash
git add -A
git commit -m 'added tests'

git remote add origin git@bitbucket.org:wsvincent/mb-app.git
git push -u origin master
```

## Heroku configuration

```bash
cat > Pipfile <<ZZZ
[requires]
python_version = "3.8"
ZZZ
```




```bash
pipenv lock
```

```bash
cat > Procfile <<ZZZ
web: gunicorn mb_project.wsgi --log-file -
ZZZ
```

```bash
pipenv install gunicorn
```



### Наконец, обновите ALLOWED_HOSTS в нашем файле settings.py
```bash
cat > mb_project/settings.py <<ZZZ
ALLOWED_HOSTS = ['*']
ZZZ
```

```bash
git status
git add -A
git commit -m 'New updates for Heroku deployment'
git push -u origin master
```


# Heroku развертывание
```bash
heroku login
heroku create
heroku git:remote -a
heroku config:set DISABLE_COLLECTSTATIC=1
git push heroku master
heroku ps:scale web=1
```
