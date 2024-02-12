{%- if include.class -%}
  {%- capture class -%}class="{{include.class}}"{%- endcapture -%}
{%- endif -%}
{%- if include.title -%}
  {%- assign title = include.title -%}
{%- elsif include.class == "exercise" -%}
  {%- assign title = "Practice" -%}
{%- endif -%}
<section markdown="1" {{class}}>
<h2 {{class}} markdown="1">{{title}}</h2>
