# The name of this view in Looker is "Cases"
view: cases {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  # sql_table_name:  `@{GCP_PROJECT_ID}.@{SFDC_DATASET}.Cases` ;;

  derived_table: {

    sql:
   select * except(ParentDescription,Description),
           if(length(ltrim(rtrim(ParentDescription)))>173, ltrim(substring(ParentDescription, 173 , length(ParentDescription)-173)),null) ParentDescription,
          if(length(ltrim(rtrim(Description)))>173, ltrim(substring(Description, 173 , length(Description)-173 )),null) Description,

      from
      (
      SELECT if(Pai.CaseNumber  is null ,Filho.CaseNumber,Pai.CaseNumber) as  ParentCaseNumber
      , if(Pai.CaseNumber  is null ,Filho.Subject,Pai.Subject) as  ParentSubject
      , if(Pai.CaseNumber  is null ,Filho.Origin,Pai.Origin) as  ParentOrigin
      , ltrim(rtrim(if(Pai.CaseNumber  is null ,Filho.SuppliedEmail,Pai.SuppliedEmail))) as  ParentSuppliedEmail
      , if(Pai.CaseNumber  is null ,Filho.SuppliedName,Pai.SuppliedName) as  ParentSuppliedName
      , if(Pai.CaseNumber  is null ,Filho.Type,Pai.Type) as  ParentType
      , if(Pai.CaseNumber  is null ,Filho.CaseCreatedDate,Pai.CaseCreatedDate) as  ParentCaseCreatedDate
      , if(Pai.CaseNumber  is null ,Filho.CaseClosedDate,Pai.CaseClosedDate) as  ParentCaseClosedDate
      , if(Pai.CaseNumber  is null ,Filho.Description,Pai.Description) as  ParentDescription
      , if(Pai.CaseNumber  is null ,Filho.ConsultantEmail,Pai.ConsultantEmail) as  ParentConsultantEmail
      , if(Pai.CaseNumber  is null ,Filho.ConsultantName,Pai.ConsultantName) as  ParentConsultantName
      , if(Pai.CaseNumber  is null ,Filho.Portfolio,Pai.Portfolio) as  ParentPortfolio
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
      , Filho.Description
      , Filho.ConsultantEmail
      , Filho.ConsultantName
      , Filho.Portfolio
      , DATE_DIFF(Filho.CaseClosedDate, coalesce(Filho.CaseCreatedDate, current_date()), day) dias_em_aberto
      FROM  `cdp-eqtl-servico.cortex_ouro_reporting_sfdc.Cases` Filho
      LEFT JOIN `cdp-eqtl-servico.cortex_ouro_reporting_sfdc.Cases` Pai on Filho.ParentId = Pai.CaseId

      )

      ;;

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

  dimension: parent_description {
    label: "Conteudo e-email (caso pai)"
    type: string
    sql: ${TABLE}.ParentDescription ;;
  }


  dimension: parent_supplied_name {
    label: "Remetente (caso pai)"
    type: string
    sql: ${TABLE}.ParentSuppliedName ;;
  }

  dimension: parent_supplied_email {
    label: "E-mail (caso pai)"
    type: string
    sql: ${TABLE}.ParentSuppliedEmail ;;
  }

  dimension: parent_consultant_name {
    label: "Nome Consultor (caso pai)"
    type: string
    sql: ${TABLE}.ParentConsultantName ;;
  }

  dimension: parent_consultant_email {
    label: "E-mail Consultor (caso pai)"
    type: string
    sql: ${TABLE}.ParentConsultantEmail ;;
  }

  dimension: parent_portfolio {
    label: "Portfolio (caso pai)"
    type: string
    sql: ${TABLE}.ParentPortfolio ;;
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

  dimension: description {
    label: "Conteudo e-email"
    type: string
    sql: ${TABLE}.Description ;;
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

  dimension: consultant_name {
    label: "Nome Consultor"
    type: string
    sql: ${TABLE}.ConsultantName ;;
  }

  dimension: consultant_email {
    label: "E-mail Consultor"
    type: string
    sql: ${TABLE}.ConsultantEmail ;;
  }

  dimension: portfolio {
    label: "Portfolio"
    type: string
    sql: ${TABLE}.Portfolio ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  measure: total_case {
    label: "Interações"
    type: count_distinct
    sql:${TABLE}.CaseNumber;;
    drill_fields: [case_number,case_created_date,parent_case_number, supplied_name,supplied_email,subject,description]
  }

  measure: dias_em_aberto {
    label: "Dias em aberto"
    type: sum
    sql:${TABLE}.dias_em_aberto;;
    drill_fields: [case_number,case_created_date,parent_case_number, supplied_name,supplied_email,subject,description]
  }

  measure: total_case_pai {
    label: "N° de casos (pai)"
    type: count_distinct
    sql: ${TABLE}.ParentCaseNumber  ;;
    drill_fields: [parent_case_number,parent_case_created_date, parent_supplied_name,parent_supplied_email,parent_subject,parent_description]
  }
}
