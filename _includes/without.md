{% capture prefix %}{{include.file | split: "." | first}}{% endcapture %}
{% capture suffix %}{{include.file | split: "." | last}}{% endcapture %}
{% capture content %}{% include_relative src/{{include.file}} %}{% endcapture %}
{% if suffix == "sql" %}
{% capture content %}{{content | split: "-- start" | last | split: "-- end" | first}}{% endcapture %}
{% elsif suffix == "py" %}
{% capture content %}{{content | split: "# -- start" | last | split: "# -- end" | first}}{% endcapture %}
{% endif %}
```{{suffix}}
{{content | strip}}
```
{% capture content %}{% include_relative out/{{prefix}}.out %}{% endcapture %}
```
{{content | strip}}
```
