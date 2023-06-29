# Macros

> https://copier.readthedocs.io/en/stable/configuring/#importing-jinja-templates-and-macros

1. To include file

```jinja
{% include pathjoin('macros', 'example.jinja') %}
```

1. To import macros

```jinja
{% pathjoin('macros', 'example.jinja') import example %}{{ example(name) }}
```

## How to define macros

```jinja
{% macro example(value) -%}
{{ value|lower|replace(' ', '-') }}
{%- endmacro %}
```
