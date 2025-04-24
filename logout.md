---
layout: default
title: Logout
permalink: /logout/
---

<script>
localStorage.removeItem('currentUser');
window.location.href = '/';
</script>
