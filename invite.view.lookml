- view: invite
  sql_table_name: invite

  fields:

  - dimension: carrier
    sql: trim(${TABLE}.carrier)

  - dimension_group: clicked
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.clickedAt

  - dimension:  did_click
    type: yesno
    sql: ${TABLE}.clickedAt
    
  - dimension: client_recipient_number
    sql: ${TABLE}.clientRecipientNumber


  - dimension: recipient_area_code
    sql: |
        greatest(
        cast(substring(cast(${client_recipient_number} as signed) from 3 for 3) as signed),
        cast(substring(cast(${client_recipient_number} as signed) from 2 for 3) as signed), 
        cast(substring(cast(${client_recipient_number} as signed) from 1 for 3) as signed))

            
  - dimension: full_copy
    sql: ${TABLE}.copy

  - dimension: copy
    sql: SUBSTRING_INDEX(${TABLE}.copy, 'http',1)
    
  - dimension: domain
    sql: ${TABLE}.domain

  - dimension_group: initiated
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.initiatedAt

  - dimension:  did_initiate
    type: yesno
    sql: ${TABLE}.initiatedAt
    
  - dimension_group: installed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.installedAt

  - dimension:  did_install
    type: yesno
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

  - dimension:  did_register
    type: yesno
    sql: ${TABLE}.registeredAt
    
  - dimension: status
    type: number
    sql: cast(${TABLE}.status AS signed)
    
  - dimension: status_error
    type: yesno
    sql:  ${status} !=1
  - dimension: pseudo_type
    sql_case:
      one_on_one: ${TABLE}.copy LIKE '%I just sent%'
      group:  ${TABLE}.copy LIKE '%chat in the group%'
      else: null
      
  - dimension: type
    sql_case:
      bulk: ${TABLE}.type=0
      cherry_pick: ${TABLE}.type=1
      pseudo: ${TABLE}.type=4
  - dimension: number_length
    sql:  CHAR_LENGTH(${client_recipient_number})
    
  - dimension: bad_number
    sql:  |
        (CASE WHEN ${status} !=1 THEN 'true' 
         WHEN ${recipient_area_code} IN ('800','888','866','326') THEN 'true' 
         WHEN ${number_length}<10 THEN 'true' 
        ELSE 'false' 
        END)
     
      
  - dimension_group: updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updatedAt

  - measure: count
    type: count
    drill_fields: []

  - measure: sender_count
    type: count_distinct
    sql:  ${TABLE}.invitorId
    
  - measure:  invites_per_sender
    type: number
    sql: ${count}/${sender_count}
    
  - measure: registrations_per_hundred_senders
    type: number
    sql:  100*${count_registered}/${sender_count}
    
  - measure: count_registered
    type: count
    filters:
      did_register: yes

  - measure: count_installed
    type: count
    filters:
      did_install: yes

  - measure: count_clicked
    type: count
    filters:
      did_click: yes

  - measure:  click_rate
    type: number
    decimals: 1
    sql:  100.0*${count_clicked}/${count}
    
  - measure:  install_rate
    type: number
    decimals: 1
    sql:  100.0*${count_installed}/${count}

  - measure:  registration_rate
    type: number
    decimals: 1
    sql:  100.0* ${count_registered}/${count}
    
  - measure:  click_to_install_rate
    type: number
    decimals: 1
    sql:  100.0*${count_installed}/${count_clicked}

  - measure:  install_to_registration_rate
    type: number
    decimals: 1
    sql:  100.0*${count_registered}/${count_installed}
    
  - measure: percent_of_invites
    type: percent_of_total
    decimals: 1
    sql: ${count}
