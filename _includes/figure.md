{%- capture figure_id -%}{% increment figure_counter %}{%- endcapture -%}
<figure id="figure_{{figure_id}}">
<img src="{{include.file}}" alt="{{include.alt}}"/>
<figcaption>Figure {{figure_id}}: {{include.title}}</figcaption>
</figure>
