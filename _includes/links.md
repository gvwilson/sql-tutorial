{% for entry in include.links %}
[{{entry.key}}]: {{entry.value}}
{% endfor %}
