{% test email_format(model, column_name) %}
    select
    *
    from {{ model }}
    where not regexp_contains({{ column_name }}, r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}")
{% endtest %}
