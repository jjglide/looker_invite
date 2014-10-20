- view: invite
  fields:

  - dimension: carrier
    sql: ${TABLE}.carrier

  - dimension_group: clicked
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.clickedAt

  - dimension: client_recipient_number
    sql: ${TABLE}.clientRecipientNumber

  - dimension: copy
    sql: ${TABLE}.copy

  - dimension: domain
    sql: ${TABLE}.domain

  - dimension_group: initiated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.initiatedAt

  - dimension_group: installed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.installedAt

  - dimension: invitor_id
    sql: ${TABLE}.invitorId

  - dimension: link_id
    sql: ${TABLE}.linkID

  - dimension: other_emails
    sql: ${TABLE}.otherEmails

  - dimension: other_numbers
    sql: ${TABLE}.otherNumbers

  - dimension: recipient_number
    sql: ${TABLE}.recipientNumber

  - dimension_group: registered
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.registeredAt

  - dimension: status
    type: yesno
    sql: ${TABLE}.status

  - dimension: type
    type: yesno
    sql: ${TABLE}.type

  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updatedAt

  - measure: count
    type: count
    drill_fields: []

