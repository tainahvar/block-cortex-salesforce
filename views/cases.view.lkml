# The name of this view in Looker is "Cases"
view: cases {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name:  `@{GCP_PROJECT_ID}.@{SFDC_DATASET}.Cases` ;;


  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: case_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.CaseId ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account ID" in Explore.

  dimension: account_id {
    type: string
    sql: ${TABLE}.AccountId ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: case_closed {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CaseClosedDate ;;
  }

  dimension: caseclosedmonth {
    type: number
    sql: ${TABLE}.CaseClosedMonth ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_case_closed_month {
    type: sum
    sql: ${case_closed_month} ;;  }

  measure: average_case_closed_month {
    type: average
    sql: ${case_closed_month} ;;  }

  measure: total_case {
    type: count_distinct
    sql:${TABLE}.CaseNumber;;  }

  measure: total_case_pai {
    label: "N° de casos"
    type: count_distinct
    sql: if(${TABLE}.ParentId ='',${TABLE}.CaseId,${TABLE}.ParentId) ;;  }

  dimension: caseclosedquarter {
    type: string
    sql: ${TABLE}.CaseClosedQuarter ;;
  }

  dimension: caseclosedweek {
    type: number
    sql: ${TABLE}.CaseClosedWeek ;;
  }

  dimension: caseclosedyear {
    type: number
    sql: ${TABLE}.CaseClosedYear ;;
  }

  dimension_group: case_created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CaseCreatedDate ;;
  }

  dimension: casecreatedmonth {
    type: number
    sql: ${TABLE}.CaseCreatedMonth ;;
  }

  dimension: casecreatedquarter {
    type: string
    sql: ${TABLE}.CaseCreatedQuarter ;;
  }

  dimension: casecreatedweek {
    type: number
    sql: ${TABLE}.CaseCreatedWeek ;;
  }

  dimension: casecreatedyear {
    type: number
    sql: ${TABLE}.CaseCreatedYear ;;
  }

  dimension: case_number {
    type: string
    sql: ${TABLE}.CaseNumber ;;
  }

  dimension_group: closed_datestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.ClosedDatestamp ;;
  }

  dimension: comments {
    type: string
    sql: ${TABLE}.Comments ;;
  }

  dimension: contact_email {
    type: string
    sql: ${TABLE}.ContactEmail ;;
  }

  dimension: contact_fax {
    type: string
    sql: ${TABLE}.ContactFax ;;
  }

  dimension: contact_id {
    type: string
    sql: ${TABLE}.ContactId ;;
  }

  dimension: contact_mobile {
    type: string
    sql: ${TABLE}.ContactMobile ;;
  }

  dimension: contact_phone {
    type: string
    sql: ${TABLE}.ContactPhone ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.CreatedById ;;
  }

  dimension_group: created_datestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.CreatedDatestamp ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: is_escalated {
    type: yesno
    sql: ${TABLE}.IsEscalated ;;
  }

  dimension: isclosed {
    type: yesno
    sql: ${TABLE}.Isclosed ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.Language ;;
  }

  dimension: last_modified_by_id {
    type: string
    sql: ${TABLE}.LastModifiedById ;;
  }

  dimension_group: last_modified_datestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.LastModifiedDatestamp ;;
  }

  dimension_group: last_referenced_datestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.LastReferencedDatestamp ;;
  }

  dimension_group: last_viewed_datestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.LastViewedDatestamp ;;
  }

  dimension: master_record_id {
    type: string
    sql: ${TABLE}.MasterRecordId ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.Origin ;;
  }

  dimension: origin_client {
    type: string
    sql: ${TABLE}.OriginClient ;;
  }

  dimension: owner_id {
    type: string
    sql: ${TABLE}.OwnerId ;;
  }

  dimension: parent_id {
    type: string
    sql: ${TABLE}.ParentId ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.Priority ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.Reason ;;
  }

  dimension: record_type_id {
    type: string
    sql: ${TABLE}.RecordTypeId ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.Subject ;;
  }

  dimension: supplied_company {
    type: string
    sql: ${TABLE}.SuppliedCompany ;;
  }

  dimension: supplied_email {
    label: "E-mail Fornecido"
    type: string
    sql: ${TABLE}.SuppliedEmail ;;
  }

  dimension: supplied_name {
    type: string
    sql: ${TABLE}.SuppliedName ;;
  }

  dimension: supplied_phone {
    type: string
    sql: ${TABLE}.SuppliedPhone ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }
  measure: count {
    type: count
    drill_fields: [case_number, supplied_name]
  }
}
