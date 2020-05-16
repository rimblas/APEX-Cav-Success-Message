function set_apex_success
(
  p_process in apex_plugin.t_process,
  p_plugin  in apex_plugin.t_plugin 
) return apex_plugin.t_process_exec_result
is
  l_plugin_result       apex_plugin.t_process_exec_result;

  -- l_config              varchar2(4000) := p_process.attribute_01;
  l_replace_or_append   varchar2(255) := p_process.attribute_01;
  l_entity_name         varchar2(255) := p_process.attribute_02;
  l_request_1           varchar2(255) := ':' || p_process.attribute_03 || ':';
  l_request_1_message   varchar2(255) := p_process.attribute_04;
  l_request_2           varchar2(255) := ':' || p_process.attribute_05 || ':';
  l_request_2_message   varchar2(255) := p_process.attribute_06;
  l_request_3           varchar2(255) := ':' || p_process.attribute_07 || ':';
  l_request_3_message   varchar2(255) := p_process.attribute_08;
  l_request_4           varchar2(255) := ':' || p_process.attribute_09 || ':';
  l_request_4_message   varchar2(255) := p_process.attribute_10;
  l_request_5           varchar2(255) := ':' || p_process.attribute_11 || ':';
  l_request_5_message   varchar2(255) := p_process.attribute_12;
  l_request_6           varchar2(255) := ':' || p_process.attribute_13 || ':';
  l_request_6_message   varchar2(255) := p_process.attribute_14;
  l_default_message     varchar2(255) := p_process.attribute_15;

  l_request             varchar2(255) := ':' || :REQUEST || ':';
  -- l_config_obj          json_object_t;
  
  l_success_message     varchar2(32767);
begin
  -- l_config_obj := json_object_t.parse (l_config);

  -- l_replace_or_append := l_config_obj.get_string('append_or_replace');
  
  if instr (l_request_1, l_request) > 0
  then
    l_success_message := l_request_1_message;
    
  elsif instr (l_request_2, l_request) > 0
  then
    l_success_message := l_request_2_message;

  elsif instr (l_request_3, l_request) > 0
  then
    l_success_message := l_request_3_message;

  elsif instr (l_request_4, l_request) > 0
  then
    l_success_message := l_request_4_message;

  elsif instr (l_request_5, l_request) > 0
  then
    l_success_message := l_request_5_message;

  elsif instr (l_request_6, l_request) > 0
  then
    l_success_message := l_request_5_message;

  else 
    l_success_message := l_default_message;
  end if;
  
  l_success_message := replace (l_success_message, '#ENTITY#', l_entity_name);

  l_success_message := apex_plugin_util.replace_substitutions (p_value    =>  l_success_message);

  -- Hack for if we are appending messages and we don't want the default message say from a form "1 Row Updated" - Put this placeholder in the Success Message on the Form process
  apex_application.g_print_success_message := replace (apex_application.g_print_success_message, '#DISCARD#');
 
  if l_replace_or_append = 'REPLACE'
  then 
    apex_application.g_print_success_message := l_success_message;
    
  else
    apex_application.g_print_success_message := case when apex_application.g_print_success_message is not null then apex_application.g_print_success_message || '<br>' end 
                                               || l_success_message;
  end if;
  
  -- Add it to a global for the purpose of dialog closed pages
  apex_util.set_session_state ('PLUGIN_SUCCESS_MESSAGE', apex_application.g_print_success_message, false);
  
  return l_plugin_result;
end set_apex_success;