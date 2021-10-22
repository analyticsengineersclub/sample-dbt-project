
with

pull_requests as (
    select * from {{ ref('stg_github__pull_requests') }}
),

repositories as (
    select * from {{ ref('stg_github__repositories') }}
),

issues as (
    select * from {{ ref('stg_github__issues') }}
),

issues_merged as (
    select * from {{ ref('stg_github__issues_merged') }}
),

final as (
    select
        pull_requests.pull_request_id,
        repositories.name as repo_name,
        issues.number as pull_request_number,

        -- TODO: find out how to label these PRs
        cast(null as string) as type, -- (bug, eng, feature),

        case
            when pull_requests.is_draft then 'draft'
            when issues_merged.merged_at is not null then 'merged'
            when issues.closed_at is not null then 'closed_without_merge'
            else 'open'
        end as state,

        issues.created_at as opened_at,
        issues_merged.merged_at,
        round(date_diff(issues_merged.merged_at, issues.created_at, hour) / 24.0, 2) as days_open_to_merge

    from pull_requests

    left join repositories
        on pull_requests.head_repo_id = repositories.repo_id

    left join issues
        on pull_requests.issue_id = issues.issue_id

    left join issues_merged
        on pull_requests.issue_id = issues_merged.issue_id
)

select * from final
