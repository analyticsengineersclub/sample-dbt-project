with source as (

    select * from {{ source('github', 'issue') }}

),

renamed as (

    select
        id as issue_id,
        _fivetran_synced,
        body,
        closed_at,
        created_at,
        locked,
        milestone_id,
        number,
        pull_request,
        repository_id,
        state,
        title,
        updated_at,
        user_id

    from source

)

select * from renamed
