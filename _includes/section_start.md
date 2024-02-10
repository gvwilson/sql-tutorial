{%- if include.class -%}{%- capture class -%}class="{{include.class}}"{%- endcapture -%}{%- endif -%}
<section markdown="1" {{class}}>
<h2 {{class}} markdown="1">{% if include.title %}{{include.title}}{% endif %}</h2>
