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
      <h3 class="post-title">
      <a href="../{{ link }}">
        {{ title }}
      </a>
      </h3>
      <span class="post-date">{{ date }}</span>    
      {{ description }}
    </div>
    {{/ date }}{{/ pages }}
 </div>
</div>
