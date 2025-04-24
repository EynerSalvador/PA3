---
layout: home
title: Portafolio Grupal
---

{% raw %}{% unless site.data.current_user %}
  {% include login_form.html %}
{% endunless %}

<h1>Bienvenidos a nuestro portafolio</h1>

<div class="members-grid">
  {% for member in site.data.members.members %}
    <div class="member-card">
      <h3>{{ member.name }}</h3>
      <p><strong>Rol:</strong> {{ member.role }}</p>
      <p><strong>Habilidades:</strong> {{ member.skills | join: ", " }}</p>
      <p>{{ member.bio }}</p>
      {% if site.data.current_user %}
        <a href="/portfolio/{{ member.name | slugify }}" class="btn">Ver portafolio completo</a>
      {% endif %}
    </div>
  {% endfor %}
</div>{% endraw %}
