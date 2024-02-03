{%- capture src_suffix -%}{{include.suffix | split: " " | first}}{%- endcapture -%}
{%- capture out_suffix -%}{{include.suffix | split: " " | last}}{%- endcapture -%}

{%- capture content -%}{%- include_relative src/{{include.stem}}.{{src_suffix}} -%}{%- endcapture -%}
{%- if src_suffix == "sql" -%}
{%- capture content -%}{{content | split: "-- start" | last | split: "-- end" | first}}{%- endcapture -%}
{%- elsif src_suffix == "py" -%}
{%- capture content -%}{{content | split: "# start" | last | split: "# end" | first}}{%- endcapture -%}
{%- endif -%}

```{{src_suffix}}
{{content | strip}}
```

{% capture content -%}{%- include_relative out/{{include.stem}}.{{out_suffix}} -%}{%- endcapture -%}
```
{{content | strip}}
```
