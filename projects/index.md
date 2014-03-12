---
framework: lanyon
onefile: False
mode: selfcontained
url: {lib: ../libraries}
---

## Projects

{{# site.projects }}
<a href="{{url}}">
  <p>{{ title }}</p>
  <img src=thumbnails/{{ thumbnail }}></img>
</a>
{{/ site.projects }}


<style>
  li{text-align: justify;}
  img {
  	height: 140px;
  	width: 720px;
  	overflow: hidden;
  	border: 1px solid gray;
  }
</style>



