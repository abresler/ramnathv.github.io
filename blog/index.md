---
framework: lanyon
layout: main
onefile: False
mode: selfcontained
url: {lib: ../libraries}
---


<div class="container content">
  <div class="posts">
    {{# pages }}{{# date }}
    <div class="post">
      <span class="post-date">{{ date }}</span>
      <h3 class="post-title">
      <a href="../{{ link }}">
        {{ title }}
      </a>
      </h3>

      
      {{ description }}
    </div>
    {{/ date }}{{/ pages }}
 </div>
</div>
