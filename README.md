
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
heroku apps:create easy-blog-django
heroku git:remote -a easy-blog-django
heroku config:set DISABLE_COLLECTSTATIC=1
git push heroku master
heroku ps:scale web=1
```
mkdir static

>Как и в нашей папке с шаблонами, нам нужно обновить settings.py, чтобы сообщить Django,
>где искать эти статические файлы. Мы можем обновить settings.py с изменением строки для
>STATICFILES_DIRS. Добавьте его в нижнюю часть файла под заголовком STATIC_URL.


```bash
# blog_project/settings.py
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]
```

Теперь создайте папку css в static и добавьте в нее новый файл base.css. 

```bash
mkdir static/css
touch static/css/base.css
```
```bash
cat > blog/views.py <<ZZZ
# blog/views.py
from django.views.generic import ListView, DetailView
from .models import Post


class BlogListView(ListView):
    model = Post
    template_name = 'home.html'


class BlogDetailView(DetailView):
    model = Post
    template_name = 'post_detail.html'
ZZZ
```

```bash
cat > templates/base.html <<ZZZ
<!-- templates/base.html -->
{% load static %}
<html>
	<head>
		<title>Django blog</title>
		<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400" rel="stylesheet">
		<link rel="stylesheet" href="{% static 'css/base.css' %}">
	</head>
	<body>
		<header>
			<h1><a href="/">Django blog</a></h1>
		</header>
		<div class="container">
			{% block content %}
			{% endblock content %}
		</div>
	</body>
</html>
ZZZ
```

Затем обновите наш css файл, скопировав и вставив следующий код:

```bash
cat > static/css/base.css <<ZZZ
/* static/css/base.css */
body {
font-family: 'Source Sans Pro', sans-serif;
font-size: 18px;
}
header {
border-bottom: 1px solid #999;
margin-bottom: 2rem;
display: flex;
}
header h1 a {
color: red;
text-decoration: none;
}
.nav-left {
margin-right: auto;
}
.nav-right {
display: flex;
padding-top: 2rem;
}
.post-entry {
margin-bottom: 2rem;
}
.post-entry h2 {
margin: 0.5rem 0;
}
.post-entry h2 a,
.post-entry h2 a:visited {
color: blue;
text-decoration: none;
}
.post-entry p {
margin: 0;
font-weight: 400;
}
.post-entry h2 a:hover {
color: red;
}
ZZZ
```

```bash
cat > templates/post_detail.html <<ZZZ
<!-- templates/post_detail.html -->
{% extends 'base.html' %}
{% block content %}
	<div class="post-entry">
		<h2>{{ object.title }}</h2>
		<p>{{ object.body }}</p>
	</div>
{% endblock content %}
ZZZ
```
