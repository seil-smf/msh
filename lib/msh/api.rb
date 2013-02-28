module Msh
  module Api
    #Home API
    autoload :GETHome, "msh/api/get_home"
    autoload :GETHomeModule, "msh/api/get_home_module"
    autoload :GETHomePermission, "msh/api/get_home_permission"

    #User API
    autoload :GETUserUserCode, "msh/api/get_user_user_code"
    autoload :PUTUserUserCode, "msh/api/put_user_user_code"

    #Search API
    autoload :GETHomeSearchUsercode, "msh/api/get_home_search_usercode"
    autoload :GETHomeSearchUsername, "msh/api/get_home_search_username"
    autoload :GETHomeSearchSacode, "msh/api/get_home_search_sacode"
    autoload :GETHomeSearchSaname, "msh/api/get_home_search_saname"
    autoload :GETHomeSearchDistid, "msh/api/get_home_search_distid"

    #SA API
    autoload :GETUserUserCodeSa, "msh/api/get_user_user_code_sa"
    autoload :GETUserUserCodeSaSaCode, "msh/api/get_user_user_code_sa_sa_code"
    autoload :PUTUserUserCodeSaSaCode, "msh/api/put_user_user_code_sa_sa_code"

    #Config API
    autoload :GETUserUserCodeSaSaCodeConfig, "msh/api/get_user_user_code_sa_sa_code_config"

    #Working Config API
    autoload :GETUserUserCodeSaSaCodeConfigWorking, "msh/api/get_user_user_code_sa_sa_code_config_working"
    autoload :PUTUserUserCodeSaSaCodeConfigWorkingBlank, "msh/api/put_user_user_code_sa_sa_code_config_working_blank"
    autoload :PUTUserUserCodeSaSaCodeConfigWorkingModuleId, "msh/api/put_user_user_code_sa_sa_code_config_working_module_id"
    autoload :GETUserUserCodeSaSaCodeConfigWorkingModuleIdPlain, "msh/api/get_user_user_code_sa_sa_code_config_working_module_id_plain"
    autoload :GETUserUserCodeSaSaCodeConfigWorkingModuleIdBinary, "msh/api/get_user_user_code_sa_sa_code_config_working_module_id_binary"
    autoload :PUTUserUserCodeSaSaCodeConfigWorkingModuleIdPlain, "msh/api/put_user_user_code_sa_sa_code_config_working_module_id_plain"
    autoload :PUTUserUserCodeSaSaCodeConfigWorkingModuleIdBinary, "msh/api/put_user_user_code_sa_sa_code_config_working_module_id_binary"

    #Preview Config API
    autoload :GETUserUserCodeSaSaCodeConfigPreviewModuleIdPlain, "msh/api/get_user_user_code_sa_sa_code_config_preview_module_id_plain"
    autoload :GETUserUserCodeSaSaCodeConfigPreviewModuleIdBinary, "msh/api/get_user_user_code_sa_sa_code_config_preview_module_id_binary"

    #Startup Config API
    autoload :GETUserUserCodeSaSaCodeConfigStartup, "msh/api/get_user_user_code_sa_sa_code_config_startup"
    autoload :PUTUserUserCodeSaSaCodeConfigStartup, "msh/api/put_user_user_code_sa_sa_code_config_startup"
    autoload :GETUserUserCodeSaSaCodeConfigStartupModuleIdPlain, "msh/api/get_user_user_code_sa_sa_code_config_startup_module_id_plain"
    autoload :GETUserUserCodeSaSaCodeConfigStartupModuleIdBinary, "msh/api/get_user_user_code_sa_sa_code_config_startup_module_id_binary"

    #Running Config API
    autoload :GETUserUserCodeSaSaCodeConfigRunning, "msh/api/get_user_user_code_sa_sa_code_config_running"
    autoload :PUTUserUserCodeSaSaCodeConfigRunning, "msh/api/put_user_user_code_sa_sa_code_config_running"
    autoload :GETUserUserCodeSaSaCodeConfigRunningModuleIdPlain, "msh/api/get_user_user_code_sa_sa_code_config_running_module_id_plain"
    autoload :GETUserUserCodeSaSaCodeConfigRunningModuleIdBinary, "msh/api/get_user_user_code_sa_sa_code_config_running_module_id_binary"

    #Folder API
    autoload :GETUserUserCodeSagroup, "msh/api/get_user_user_code_sagroup"
    autoload :POSTUserUserCodeSagroup, "msh/api/post_user_user_code_sagroup"
    autoload :GETUserUserCodeSagroupId, "msh/api/get_user_user_code_sagroup_id"
    autoload :PUTUserUserCodeSagroupId, "msh/api/put_user_user_code_sagroup_id"
    autoload :DELETEUserUserCodeSagroupId, "msh/api/delete_user_user_code_sagroup_id"

    #Monitor API
    autoload :GETUserUserCodeMonitor, "msh/api/get_user_user_code_monitor"
    autoload :POSTUserUserCodeMonitor, "msh/api/post_user_user_code_monitor"
    autoload :GETUserUserCodeMonitorId, "msh/api/get_user_user_code_monitor_id"
    autoload :PUTUserUserCodeMonitorId, "msh/api/put_user_user_code_monitor_id"
    autoload :DELETEUserUserCodeMonitorId, "msh/api/delete_user_user_code_monitor_id"

    #Template API
    autoload :GETUserUserCodeTemplate, "msh/api/get_user_user_code_template"
    autoload :POSTUserUserCodeTemplate, "msh/api/post_user_user_code_template"
    autoload :GETUserUserCodeTemplateId, "msh/api/get_user_user_code_template_id"
    autoload :PUTUserUserCodeTemplateId, "msh/api/put_user_user_code_template_id"
    autoload :DELETEUserUserCodeTemplateId, "msh/api/delete_user_user_code_template_id"

    #Template Config API
    autoload :GETUserUserCodeTemplateIdConfigModuleIdPlain, "msh/api/get_user_user_code_template_id_config_module_id_plain"
    autoload :PUTUserUserCodeTemplateIdConfigModuleIdPlain, "msh/api/put_user_user_code_template_id_config_module_id_plain"
    autoload :DELETEUserUserCodeTemplateIdConfigModuleIdPlain, "msh/api/delete_user_user_code_template_id_config_module_id_plain"

    #Template Variable (Template set) API
    autoload :GETUserUserCodeTemplateIdVariable, "msh/api/get_user_user_code_template_id_variable"
    autoload :POSTUserUserCodeTemplateIdVariable, "msh/api/post_user_user_code_template_id_variable"
    autoload :GETUserUserCodeTemplateIdVariableName, "msh/api/get_user_user_code_template_id_variable_name"
    autoload :PUTUserUserCodeTemplateIdVariableName, "msh/api/put_user_user_code_template_id_variable_name"
    autoload :DELETEUserUserCodeTemplateIdVariableName, "msh/api/delete_user_user_code_template_id_variable_name"

    #Template Variable (SA) API
    autoload :GETUserUserCodeTemplateIdSaSaCodeVariable, "msh/api/get_user_user_code_template_id_sa_sa_code_variable"
    autoload :PUTUserUserCodeTemplateIdSaSaCodeVariable, "msh/api/put_user_user_code_template_id_sa_sa_code_variable"

    #Template Set (CSV) API
    autoload :GETUserUserCodeTemplateIdPackCsv, "msh/api/get_user_user_code_template_id_pack_csv"
    autoload :PUTUserUserCodeTemplateIdPackCsv, "msh/api/put_user_user_code_template_id_pack_csv"

    #Request API
    autoload :GETUserUserCodeRequest, "msh/api/get_user_user_code_request"

    #Ping API
    autoload :POSTUserUserCodeRequestPing, "msh/api/post_user_user_code_request_ping"
    autoload :GETUserUserCodeRequestPingId, "msh/api/get_user_user_code_request_ping_id"
    autoload :PUTUserUserCodeRequestPingId, "msh/api/put_user_user_code_request_ping_id"

    #Traceroute API
    autoload :POSTUserUserCodeRequestTraceroute, "msh/api/post_user_user_code_request_traceroute"
    autoload :GETUserUserCodeRequestTracerouteId, "msh/api/get_user_user_code_request_traceroute_id"
    autoload :PUTUserUserCodeRequestTracerouteId, "msh/api/put_user_user_code_request_traceroute_id"

    #Read Storae API
    autoload :POSTUserUserCodeRequestReadStorage, "msh/api/post_user_user_code_request_read_storage"
    autoload :GETUserUserCodeRequestReadStorageId, "msh/api/get_user_user_code_request_read_storage_id"
    autoload :PUTUserUserCodeRequestReadStorageId, "msh/api/put_user_user_code_request_read_storage_id"
    autoload :GETUserUserCodeRequestReadStorageIdResultModuleModuleIdPlain, "msh/api/get_user_user_code_request_read_storage_id_result_module_module_id_plain"
    autoload :GETUserUserCodeRequestReadStorageIdResultModuleModuleIdBinary, "msh/api/get_user_user_code_request_read_storage_id_result_module_module_id_binary"

    #Read Status API
    autoload :POSTUserUserCodeRequestReadStatus, "msh/api/post_user_user_code_request_read_status"
    autoload :GETUserUserCodeRequestReadStatusId, "msh/api/get_user_user_code_request_read_status_id"
    autoload :PUTUserUserCodeRequestReadStatusId, "msh/api/put_user_user_code_request_read_status_id"
    autoload :GETUserUserCodeRequestReadStatusIdRequestModuleModuleIdPlain, "msh/api/get_user_user_code_request_read_status_id_request_module_module_id_plain"
    autoload :GETUserUserCodeRequestReadStatusIdRequestModuleModuleIdBinary, "msh/api/get_user_user_code_request_read_status_id_request_module_module_id_binary"
    autoload :GETUserUserCodeRequestReadStatusIdResultModuleModuleIdPlain, "msh/api/get_user_user_code_request_read_status_id_result_module_module_id_plain"
    autoload :GETUserUserCodeRequestReadStatusIdResultModuleModuleIdBinary, "msh/api/get_user_user_code_request_read_status_id_result_module_module_id_binary"

    #Clear Status API
    autoload :POSTUserUserCodeRequestClearStatus, "msh/api/post_user_user_code_request_clear_status"
    autoload :GETUserUserCodeRequestClearStatusId, "msh/api/get_user_user_code_request_clear_status_id"
    autoload :PUTUserUserCodeRequestClearStatusId, "msh/api/put_user_user_code_request_clear_status_id"
    autoload :GETUserUserCodeRequestClearStatusIdRequestModuleModuleIdPlain, "msh/api/get_user_user_code_request_clear_status_id_request_module_module_id_plain"
    autoload :GETUserUserCodeRequestClearStatusIdRequestModuleModuleIdBinary, "msh/api/get_user_user_code_request_clear_status_id_request_module_module_id_binary"
    autoload :GETUserUserCodeRequestClearStatusIdResultModuleModuleIdPlain, "msh/api/get_user_user_code_request_clear_status_id_result_module_module_id_plain"
    autoload :GETUserUserCodeRequestClearStatusIdResultModuleModuleIdBinary, "msh/api/get_user_user_code_request_clear_status_id_result_module_module_id_binary"

    #Md Command API
    autoload :POSTUserUserCodeRequestMdCommand, "msh/api/post_user_user_code_request_md_command"
    autoload :GETUserUserCodeRequestMdCommandId, "msh/api/get_user_user_code_request_md_command_id"
    autoload :PUTUserUserCodeRequestMdCommandId, "msh/api/put_user_user_code_request_md_command_id"
    autoload :GETUserUserCodeRequestMdCommandIdRequestModuleModuleIdPlain, "msh/api/get_user_user_code_request_md_command_id_request_module_module_id_plain"
    autoload :GETUserUserCodeRequestMdCommandIdRequestModuleModuleIdBinary, "msh/api/get_user_user_code_request_md_command_id_request_module_module_id_binary"
    autoload :GETUserUserCodeRequestMdCommandIdResultModuleModuleIdPlain, "msh/api/get_user_user_code_request_md_command_id_result_module_module_id_plain"
    autoload :GETUserUserCodeRequestMdCommandIdResultModuleModuleIdBinary, "msh/api/get_user_user_code_request_md_command_id_result_module_module_id_binary"


    #Reboot API
    autoload :POSTUserUserCodeRequestReboot, "msh/api/post_user_user_code_request_reboot"
    autoload :GETUserUserCodeRequestRebootId, "msh/api/get_user_user_code_request_reboot_id"
    autoload :PUTUserUserCodeRequestRebootId, "msh/api/put_user_user_code_request_reboot_id"

    #Event API
    autoload :GETUserUserCodeEvent, "msh/api/get_user_user_code_event"

    #Test API
    autoload :GETTest, "msh/api/get_test"
    autoload :POSTTest, "msh/api/post_test"
    autoload :PUTTestId, "msh/api/put_test_id"
    autoload :DELETETestId, "msh/api/delete_test_id"

  end
end
