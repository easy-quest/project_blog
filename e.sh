#!/usr/bin/bash

# cat > static/css/base.css <<ZZZ
# /* static/css/base.css */
# body {
# font-family: 'Source Sans Pro', sans-serif;
# font-size: 18px;
# }
# header {
# border-bottom: 1px solid #999;
# margin-bottom: 2rem;
# display: flex;
# }
# header h1 a {
# color: red;
# text-decoration: none;
# }
# .nav-left {
# margin-right: auto;
# }
# .nav-right {
# display: flex;
# padding-top: 2rem;
# }
# .post-entry {
# margin-bottom: 2rem;
# }
# .post-entry h2 {
# margin: 0.5rem 0;
# }
# .post-entry h2 a,
# .post-entry h2 a:visited {
# color: blue;
# text-decoration: none;
# }
# .post-entry p {
# margin: 0;
# font-weight: 400;
# }
# .post-entry h2 a:hover {
# color: red;
# }
# ZZZ

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


class BlogDetailView(DetailView):
    model = Post
    template_name = 'post_detail.html'
    context_object_name = 'anything_you_want'

ZZZ

cat > templates/post_detail.html <<ZZZ
<!-- templates/post_detail.html -->
{% extends 'base.html' %}
{% block content %}
	<div class="post-entry">
		<h2>{{ anything_you_want.title }}</h2>
		<p>{{ anything_you_want.body }}</p>
	</div>
{% endblock content %}
ZZZ