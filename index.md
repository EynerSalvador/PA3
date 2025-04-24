---
layout: home
title: Portafolio Grupal
---

# Bienvenidos a nuestro portafolio

{% for member in site.data.members.members %}
  {% include member_card.html member=member %}
{% endfor %}
