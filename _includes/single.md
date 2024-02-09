{%- comment -%}
Expected usage is `{% include single.md file="something.sql" %}`
or `{% include single.md file="something.sql" keep="label" %}`.
1.  Capture file content in `content` and split suffix into `suffix`.
2.  If the suffix is a recognized source file suffix (e.g., `sql` or `py`)
    then define `comment` to be the language's comment marker.
    Otherwise, set `comment` to `nil` to prevent slicing later on.
3.  If the suffix is `out` reset it to `nil` so that no language type
    will be specified next to the opening triple quotes later on.
    This is necessary to make Rouge set the highlighting type to `plaintext`.
4.  Define `keep` to be either the value of `include.keep` (passed in)
    or the default `"keep"`.
5.  If both `comment` and `suffix` have been set,
    manufacture the start and end markers for slicing and slice the captured text.
6.  Include the captured text with the correct file type next to the opening triple quotes.
{%- endcomment -%}

{%- capture content -%}{% include_relative {{include.file}} %}{%- endcapture -%}
{%- capture suffix -%}{{include.file | split: "." | last}}{%- endcapture -%}

{%- if suffix == "sql" -%}
  {%- assign comment = "--" -%}
{%- elsif suffix == "py" -%}
  {%- assign comment = "#" -%}
{%- elsif suffix == "out" -%}
  {%- assign comment = nil -%}
{%- endif -%}

{%- if suffix == "out" -%}
  {%- assign suffix = nil -%}
{%- endif -%}

{%- if include.keep -%}
  {%- assign keep = include.keep -%}
{%- else -%}
  {%- assign keep = "keep" -%}
{%- endif -%}

{%- if comment and suffix -%}
  {%- capture start_tag -%}{{comment}} [{{keep}}]{%- endcapture -%}
  {%- capture end_tag -%}{{comment}} [/{{keep}}]{%- endcapture -%}
  {%- capture content -%}{{content | split: start_tag | last | split: end_tag | first}}{%- endcapture -%}
{%- endif -%}

<p class="inclusion"><a href="{{include.file}}">{{include.file}}</a></p>
```{{suffix}}
{{content | strip}}
```
