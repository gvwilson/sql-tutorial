{%- capture src_suffix -%}{{include.suffix | split: " " | first}}{%- endcapture -%}
{%- capture src_file -%}src/{{include.stem}}.{{src_suffix}}{%- endcapture -%}
{%- capture out_suffix -%}{{include.suffix | split: " " | last}}{%- endcapture -%}
{%- capture out_file -%}out/{{include.stem}}.{{out_suffix}}{%- endcapture -%}

{%- capture src_content -%}{%- include_relative {{src_file}} -%}{%- endcapture -%}
{%- if src_suffix == "sql" -%}
{%- capture src_content -%}{{src_content | split: "-- start" | last | split: "-- end" | first}}{%- endcapture -%}
{%- elsif src_suffix == "py" -%}
{%- capture src_content -%}{{src_content | split: "# start" | last | split: "# end" | first}}{%- endcapture -%}
{%- endif -%}

<p class="inclusion"><a href="{{src_file}}">{{src_file}}</a></p>
```{{src_suffix}}
{{src_content | strip}}
```

{% capture out_content -%}{%- include_relative {{out_file}} -%}{%- endcapture -%}
<p class="inclusion"><a href="{{out_file}}">{{out_file}}</a></p>
```
{{out_content | strip}}
```
