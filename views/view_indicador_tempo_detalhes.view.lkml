view: view_indicador_tempo_detalhes {
  sql_table_name: `cdp-eqtl-servico.cortex_ouro_reporting_sfdc.IndicadorTempoDetalhes` ;;


  dimension: chave {
    primary_key: yes
    type: string
    hidden: yes
    sql: concat(${parent_case_number},${case_number},${message_raw});;
  }
  dimension: parent_case_number {
    label: "N° Caso Pai"
    type: string
    sql: ${TABLE}.ParentCaseNumber ;;
  }

  dimension: case_number {
    label: "N° Caso"
    type: string
    sql: ${TABLE}.CaseNumber ;;
  }

  dimension_group: created {
    label: "Data Inicio"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.CreatedDate ;;
  }

  dimension_group: closed {
    label: "Data Fim"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.ClosedDate ;;
  }
  dimension_group: message {
    label: "Data messagem"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.MessageDate ;;
  }

  dimension: acn_crm_consultant_name__c {
    label: "Consultor Nome"
    hidden: yes
    type: string
    sql: ${TABLE}.ACN_CRM_ConsultantName__c ;;
  }

  dimension: acn_crm_consultant_email__c {
    label: "Consultor"
    type: string
    sql: Replace(coalesce(${TABLE}.ACN_CRM_ConsultantEmail__c,view_indicador_tempo.consultor),"@equatorialenergia.com.br","") ;;
  }

  dimension: acn_crm_portfolio__c {
    label: "Portfólio"
    type: string
    sql: ${TABLE}.ACN_CRM_Portfolio__c ;;
  }
  dimension: assunto_mensagem {
    type: string
    sql: ${TABLE}.AssuntoMensagem ;;
  }

  dimension: statu_case {
    label: "Status"
    type: string
    sql: ${TABLE}.StatuCase ;;
  }

  dimension: recibido_de {
    label: "Recebido de:"
    type: string
    sql: ${TABLE}.RecibidoDe ;;
  }

  dimension: enviado_para {
    label: "Enviado para:"
    type: string
    sql: ${TABLE}.EnviadoPara ;;
  }

  dimension: com_copia_para {
    label: "Com copia para:"
    type: string
    sql: ${TABLE}.ComCopiaPara ;;
  }

  dimension: etapa {
    label: "Etapa"
    type: string
    sql: ${TABLE}.Etapa ;;
  }

  dimension: ordem {
    hidden: yes
    type: number
    sql: ${TABLE}.Ordem ;;
  }

  dimension_group: parent_created {
    type: time
    hidden: yes
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.ParentCreatedDate ;;
  }


  dimension: supplied_email {
    type: string
    sql: ${TABLE}.SuppliedEmail ;;
  }
  dimension: supplied_name {
    type: string
    sql: ${TABLE}.SuppliedName ;;
  }
  dimension: type {
    hidden: yes
    type: string
    sql: ${TABLE}.Type ;;
  }

  measure: qtd_casos {
    label: "Qtd. Interações"
    type: count_distinct
    sql: ${case_number} ;;
    drill_fields: [case_number]
  }
}
