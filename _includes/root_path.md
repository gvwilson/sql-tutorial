{%- if page.dir == "/" -%}
  {%- assign root = "." -%}
{%- else -%}
  {%- capture root_len -%}{{page.dir | split: "/" | size | minus: 2 | times: 3 | plus: 2}}{%- endcapture -%}
  {%- assign path_strings = "../../../../../../.." -%}
  {%- capture root -%}{{path_strings | slice: 0, root_len}}{%- endcapture -%}
{%- endif -%}
