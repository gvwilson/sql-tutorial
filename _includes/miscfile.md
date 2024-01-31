{% capture content %}{% include_relative examples/{{include.file}} %}{% endcapture %}
{% capture suffix %}{{include.file | split: "." | last}}{% endcapture %}
```{{suffix}}
{{content | strip}}
```
