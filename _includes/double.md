{%- comment -%}
Expected usage is `{% include stem="something" suffix="sql out" %}`
or  `{% include stem="something" suffix="sql out" keep="label" %}`
Turn this into inclusion using `single.md` of `src/something.sql` and `out/something.out`,
passing the `keep` value.
{%- endcomment -%}

{%- capture src_suffix -%}{{include.suffix | split: " " | first}}{%- endcapture -%}
{%- capture src_file -%}src/{{include.stem}}.{{src_suffix}}{%- endcapture -%}
{% include single.md file=src_file keep=include.keep %}

{%- capture out_suffix -%}{{include.suffix | split: " " | last}}{%- endcapture -%}
{%- capture out_file -%}out/{{include.stem}}.{{out_suffix}}{%- endcapture -%}
{% include single.md file=out_file keep=include.keep %}
