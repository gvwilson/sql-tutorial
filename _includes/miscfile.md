{% capture content %}{% include_relative {{include.file}} %}{% endcapture %}
{% capture suffix %}{{include.file | split: "." | last}}{% endcapture %}
```{{suffix}}
{{content | strip}}
```
