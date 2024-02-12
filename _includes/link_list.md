{% for entry in include.links %}
{% if entry.title %}- {{entry.title}}: [{{entry.url}}][{{entry.key}}]{% endif %}
{% endfor %}
