{% capture newline %}
{% endcapture %}
{% capture other %}{% include_relative {{include.filename}} %}{% endcapture %}
{{ other | markdownify | split: "</h1>" | last }}
