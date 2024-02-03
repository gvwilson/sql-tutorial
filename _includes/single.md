{% capture content %}{% include_relative {{include.file}} %}{% endcapture %}
{% capture suffix %}{{include.file | split: "." | last}}{% endcapture %}
<p class="inclusion"><a href="{{include.file}}">{{include.file}}</a></p>
```{{suffix}}
{{content | strip}}
```
