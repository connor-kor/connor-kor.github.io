---
title: "일기"
layout: archive
permalink: /categories/daily
author_profile: true
---

{% assign posts = site.categories.daily %}
{% for post in posts %} {% include archive-single.html type=page.entries_layout %} {% endfor %}
