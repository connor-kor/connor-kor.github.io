---
title: "CS50"
layout: archive
permalink: /categories/cs50
author_profile: true
---

{% assign posts = site.categories.cs50 %}
{% for post in posts %} {% include archive-single.html type=page.entries_layout %} {% endfor %}
