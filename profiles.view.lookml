- view: profiles
  sql_table_name: people.profiles
  fields:

  - dimension: acc
    type: number
    sql: ${TABLE}.acc

  - dimension: alt
    type: number
    sql: ${TABLE}.alt

  - dimension: approved_count
    type: number
    sql: ${TABLE}.approved_count

  - dimension: blocked
    type: yesno
    sql: ${TABLE}.Blocked

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.createdAt

  - dimension: deleted
    type: yesno
    sql: ${TABLE}.deleted

  - dimension: explicit_count
    type: number
    sql: ${TABLE}.explicit_count

  - dimension: first_name
    sql: ${TABLE}.firstName

  - dimension: gender
    sql: ${TABLE}.Gender

  - dimension: glideid
    sql: ${TABLE}.glideid

  - dimension_group: last_active
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_active

  - dimension: last_name
    sql: ${TABLE}.lastName

  - dimension: lat
    type: number
    sql: ${TABLE}.lat

  - dimension: lon
    type: number
    sql: ${TABLE}.lon

  - dimension: offensive_count
    type: number
    sql: ${TABLE}.offensive_count

  - dimension_group: review_submitted
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.review_submitted_time

  - dimension_group: review
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.review_time

  - dimension_group: user_birthdate
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.userBirthdate

  - dimension: user_status
    type: yesno
    sql: ${TABLE}.user_status

  - measure: count
    type: count
    drill_fields: [first_name, last_name]

