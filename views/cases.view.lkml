# The name of this view in Looker is "Cases"
view: cases {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  # sql_table_name:  `@{GCP_PROJECT_ID}.@{SFDC_DATASET}.Cases` ;;

  derived_table: {

    sql:
     SELECT if(Pai.CaseNumber  is null ,Filho.CaseNumber,Pai.CaseNumber) as  ParentCaseNumber
           , if(Pai.CaseNumber  is null ,Filho.Subject,Pai.Subject) as  ParentSubject
           , if(Pai.CaseNumber  is null ,Filho.Origin,Pai.Origin) as  ParentOrigin
           , if(Pai.CaseNumber  is null ,Filho.SuppliedEmail,Pai.SuppliedEmail) as  ParentSuppliedEmail
           , if(Pai.CaseNumber  is null ,Filho.SuppliedName,Pai.SuppliedName) as  ParentSuppliedName
           , if(Pai.CaseNumber  is null ,Filho.Type,Pai.Type) as  ParentType
           , if(Pai.CaseNumber  is null ,Filho.CaseCreatedDate,Pai.CaseCreatedDate) as  ParentCaseCreatedDate
           , if(Pai.CaseNumber  is null ,Filho.CaseClosedDate,Pai.CaseClosedDate) as  ParentCaseClosedDate
           , Filho.CaseId
           , Filho.CaseNumber
           , Filho.CaseCreatedDate
           , Filho.CaseClosedDate
           , Filho.Isclosed
           , Filho.IsEscalated
           , Filho.Origin Origin
           , Filho.Subject
           , Filho.Status
           , Filho.SuppliedEmail
           , Filho.SuppliedName
           , Filho.Type
        FROM  `@{GCP_PROJECT_ID}.@{SFDC_DATASET}.Cases` Filho
    LEFT JOIN `@{GCP_PROJECT_ID}.@{SFDC_DATASET}.Cases` Pai on Filho.ParentId = Pai.CaseId



      );;

  }

  dimension: parent_case_number {
    label: "Num. Caso (pai)"
    type: string
    sql: ${TABLE}.ParentCaseNumber ;;
  }

  dimension: parent_subject {
    label: "Assunto (caso pai)"
    type: string
    sql: ${TABLE}.ParentSubject ;;
  }

  dimension: parent_supplied_email {
    label: "E-mail (caso pai)"
    type: string
    sql: ${TABLE}.ParentSuppliedEmail ;;
  }

  dimension_group: parent_case_closed {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ParentCaseClosedDate ;;
  }


  dimension_group: parent_case_created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ParentCaseCreatedDate ;;
  }

  dimension: case_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.CaseId ;;
  }

  dimension: case_number {
    label: "Num. Caso"
    type: string
    sql: ${TABLE}.CaseNumber ;;
  }

  dimension_group: case_closed {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CaseClosedDate ;;
  }


  dimension_group: case_created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CaseCreatedDate ;;
  }

  dimension: is_escalated {
    label: "Foi escalado?"
    type: yesno
    sql: ${TABLE}.IsEscalated ;;
  }

  dimension: isclosed {
    label: "Está Fechado?"
    type: yesno
    sql: ${TABLE}.Isclosed ;;
  }

  dimension: origin {
    label: "Fonte de entrada"
    type: string
    sql: ${TABLE}.Origin ;;
  }

  dimension: status {
    label: "Status"
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: subject {
    label: "Assunto"
    type: string
    sql: ${TABLE}.Subject ;;
  }

  dimension: supplied_email {
    label: "E-mail"
    type: string
    sql: ${TABLE}.SuppliedEmail ;;
  }

  dimension: supplied_name {
    label: "Remetente"
    type: string
    sql: ${TABLE}.SuppliedName ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  measure: total_case {
    label: "N° de casos"
    type: count_distinct
    sql:${TABLE}.CaseNumber;;
    drill_fields: [case_number, supplied_name,supplied_email,subject]
  }

  measure: total_case_pai {
    label: "N° de casos (pai)"
    type: count_distinct
    sql: ${TABLE}.ParentCaseNumber  ;;
    drill_fields: [case_number, supplied_name,supplied_email,subject]
    }
}
