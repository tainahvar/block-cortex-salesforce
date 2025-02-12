view: view_indicador_tempo {
  sql_table_name: `cdp-eqtl-servico.cortex_ouro_reporting_sfdc.IndicadorTempo` ;;

  dimension: parent_case_number {
    label: "N° Caso (pai)"
    primary_key: yes
    type: string
    sql: ${TABLE}.ParentCaseNumber ;;
    drill_fields: [view_indicador_tempo_detalhes.case_number]
  }

  dimension_group: inicio_atendimento {
    label: "Inicio do Atendimento"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.InicioAtendimento ;;
  }

  dimension_group: data_ultimo_atendimento {
    label: "Último atendimento"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.UltimoAtendimento ;;
  }

  dimension: status_atual {
    label: "Status"
    type: string
    sql: ${TABLE}.StatusAtual ;;
  }

  dimension: etapa_atual {
    label: "Etapa atual"
    type: string
    sql: ${TABLE}.EtapaAtual ;;
  }

  dimension_group: data_envio_backoffice {
    label: "Encaminhado para Backoffice"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.EnviadoBackOffice ;;
  }

  dimension_group: data_envio_consultor {
    label: "Encaminhado para Consultor"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.EnviadoConsultor ;;
  }

  dimension_group: data_devolutiva_consultor {
    label: "Devolvido para Backoffice"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.DevlvidoBackoffice ;;
  }

  dimension_group: data_retorno_cliente {
    label: "Retornado para Cliente"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.ComunicacaoCliente ;;
  }

  measure: qtd_casos {
    label: "Qtd. Casos"
    type: count_distinct
    sql: ${parent_case_number}  ;;
  }

  measure: sum_tempo_backoffice {
    label: "Tempo Backoffice"
    type: sum
    sql: ${TABLE}.BackOfficeTime  ;;
  }

  measure: sum_tempo_consultor {
    label: "Tempo Consultor"
    type: sum
    sql: ${TABLE}.ConsultorTime  ;;
  }

  measure: sum_tempo_atendimento {
    label: "Tempo de Atendimento"
    type: sum
    sql: ${TABLE}.TempoAtendimento  ;;
  }

  measure: avg_tempo_backoffice {
    label: "Tempo Médio Backoffice"
    type: average
    sql: ${TABLE}.BackOfficeTime  ;;
  }

  measure: avg_tempo_consultor {
    label: "Tempo Médio Consultor"
    type: average
    sql: ${TABLE}.ConsultorTime  ;;
  }

  measure: avg_tempo_atendimento {
    label: "Tempo Médio Atendimento"
    type: average
    sql: ${TABLE}.TempoAtendimento  ;;
  }
}
