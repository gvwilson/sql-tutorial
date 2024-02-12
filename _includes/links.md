{% for entry in include.links %}
[{{entry.key}}]: {{entry.url}}
{% endfor %}
