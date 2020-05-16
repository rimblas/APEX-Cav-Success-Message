prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.4.00.08'
,p_default_workspace_id=>1822210963915592
,p_default_application_id=>130
,p_default_owner=>'JMR'
);
end;
/
prompt --application/shared_components/plugins/process_type/cav_success_message
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(10497914793718740)
,p_plugin_type=>'PROCESS TYPE'
,p_name=>'CAV.SUCCESS_MESSAGE'
,p_display_name=>'Cav Success Message'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function set_apex_success',
'(',
'  p_process in apex_plugin.t_process,',
'  p_plugin  in apex_plugin.t_plugin ',
') return apex_plugin.t_process_exec_result',
'is',
'  l_plugin_result       apex_plugin.t_process_exec_result;',
'',
'  -- l_config              varchar2(4000) := p_process.attribute_01;',
'  l_replace_or_append   varchar2(255) := p_process.attribute_01;',
'  l_entity_name         varchar2(255) := p_process.attribute_02;',
'  l_request_1           varchar2(255) := '':'' || p_process.attribute_03 || '':'';',
'  l_request_1_message   varchar2(255) := p_process.attribute_04;',
'  l_request_2           varchar2(255) := '':'' || p_process.attribute_05 || '':'';',
'  l_request_2_message   varchar2(255) := p_process.attribute_06;',
'  l_request_3           varchar2(255) := '':'' || p_process.attribute_07 || '':'';',
'  l_request_3_message   varchar2(255) := p_process.attribute_08;',
'  l_request_4           varchar2(255) := '':'' || p_process.attribute_09 || '':'';',
'  l_request_4_message   varchar2(255) := p_process.attribute_10;',
'  l_request_5           varchar2(255) := '':'' || p_process.attribute_11 || '':'';',
'  l_request_5_message   varchar2(255) := p_process.attribute_12;',
'  l_request_6           varchar2(255) := '':'' || p_process.attribute_13 || '':'';',
'  l_request_6_message   varchar2(255) := p_process.attribute_14;',
'  l_default_message     varchar2(255) := p_process.attribute_15;',
'',
'  l_request             varchar2(255) := '':'' || :REQUEST || '':'';',
'  -- l_config_obj          json_object_t;',
'  ',
'  l_success_message     varchar2(32767);',
'begin',
'  -- l_config_obj := json_object_t.parse (l_config);',
'',
'  -- l_replace_or_append := l_config_obj.get_string(''append_or_replace'');',
'  ',
'  if instr (l_request_1, l_request) > 0',
'  then',
'    l_success_message := l_request_1_message;',
'    ',
'  elsif instr (l_request_2, l_request) > 0',
'  then',
'    l_success_message := l_request_2_message;',
'',
'  elsif instr (l_request_3, l_request) > 0',
'  then',
'    l_success_message := l_request_3_message;',
'',
'  elsif instr (l_request_4, l_request) > 0',
'  then',
'    l_success_message := l_request_4_message;',
'',
'  elsif instr (l_request_5, l_request) > 0',
'  then',
'    l_success_message := l_request_5_message;',
'',
'  elsif instr (l_request_6, l_request) > 0',
'  then',
'    l_success_message := l_request_5_message;',
'',
'  else ',
'    l_success_message := l_default_message;',
'  end if;',
'  ',
'  l_success_message := replace (l_success_message, ''#ENTITY#'', l_entity_name);',
'',
'  l_success_message := apex_plugin_util.replace_substitutions (p_value    =>  l_success_message);',
'',
'  -- Hack for if we are appending messages and we don''t want the default message say from a form "1 Row Updated" - Put this placeholder in the Success Message on the Form process',
'  apex_application.g_print_success_message := replace (apex_application.g_print_success_message, ''#DISCARD#'');',
' ',
'  if l_replace_or_append = ''REPLACE''',
'  then ',
'    apex_application.g_print_success_message := l_success_message;',
'    ',
'  else',
'    apex_application.g_print_success_message := case when apex_application.g_print_success_message is not null then apex_application.g_print_success_message || ''<br>'' end ',
'                                               || l_success_message;',
'  end if;',
'  ',
'  -- Add it to a global for the purpose of dialog closed pages',
'  apex_util.set_session_state (''PLUGIN_SUCCESS_MESSAGE'', apex_application.g_print_success_message, false);',
'  ',
'  return l_plugin_result;',
'end set_apex_success;'))
,p_api_version=>2
,p_execution_function=>'set_apex_success'
,p_substitute_attributes=>false
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Sets an APEX success message based on the Request to avoid generic messages such as "Action Processed".  e.g. New Customer created, Customer updated, Customer deleted.',
'',
'Plugin requires an application item named PLUGIN_SUCCESS_MESSAGE',
'',
'Add the plugin as the last page process (or second to last if there is a Close Dialog process).',
'',
'If there is a Close Dialog process, its success message should be set to &PLUGIN_SUCCESS_MESSAGE.'))
,p_version_identifier=>'v1.0.0'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10498388173740872)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Behavior'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'REPLACE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Indicates whether the plugin message should replace the previous success message or append to it.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(10498660295745031)
,p_plugin_attribute_id=>wwv_flow_api.id(10498388173740872)
,p_display_sequence=>10
,p_display_value=>'Replace'
,p_return_value=>'REPLACE'
,p_is_quick_pick=>true
,p_help_text=>'Indicates the previous success message will be replaced by the plugin message'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(10499076229749823)
,p_plugin_attribute_id=>wwv_flow_api.id(10498388173740872)
,p_display_sequence=>20
,p_display_value=>'Append'
,p_return_value=>'APPEND'
,p_is_quick_pick=>true
,p_help_text=>'Indicates the previous success message will be preserved and the plugin message will be appended after it.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10499609943778224)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Entity'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Represent the entity being modified by the page. For example, in "New Todo Created", "Todo" is the entity.<br>',
'This value becomes #ENTITY# when creating a success message.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10499971623786403)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Request 1 Contains'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'CREATE'
,p_is_translatable=>false
,p_text_case=>'UPPER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10500240951790761)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Request 1 Message'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'New #ENTITY# created.'
,p_is_translatable=>true
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10500579989795142)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Request 2 Contains'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'SAVE'
,p_is_translatable=>false
,p_text_case=>'UPPER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10501392205820509)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Request 2 Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'#ENTITY# saved.'
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(10500579989795142)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10501627639825733)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Request 3 Contains'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'DELETE'
,p_is_translatable=>true
,p_text_case=>'UPPER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10501916615829857)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Request 3 Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'#ENTITY# deleted.'
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(10501627639825733)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10502236531832666)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Request 4 Contains'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_text_case=>'UPPER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10502597226835360)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Request 4 Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(10502236531832666)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10502878550838018)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Request 5 Contains'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(10502236531832666)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
,p_text_case=>'UPPER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10503111494840579)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Request 5 Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(10502878550838018)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10503416341842035)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Request 6 Contains'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_text_case=>'UPPER'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10503760442844964)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Request 6 Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(10503416341842035)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(10504044643850781)
,p_plugin_id=>wwv_flow_api.id(10497914793718740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>150
,p_prompt=>'Default Message'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'#ENTITY# processed.'
,p_is_translatable=>true
,p_help_text=>'If none of the previous requests are matched this will be the default success message.'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
