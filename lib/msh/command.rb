module Msh
  module Command
    autoload :HelpCommand,             "msh/command/help_command"

    autoload :PingCommand,             "msh/command/ping_command"
    autoload :TracerouteCommand,       "msh/command/traceroute_command"
    autoload :ReadStorageCommand,      "msh/command/read_storage_command"
    autoload :RebootCommand,           "msh/command/reboot_command"
    autoload :ReadStatusCommand,       "msh/command/read_status_command"
    autoload :ClearStatusCommand,      "msh/command/clear_status_command"
    autoload :MdCommandCommand,        "msh/command/md_command_command"

    autoload :ShowEventCommand,        "msh/command/show_event_command"
    autoload :ShowMshrcCommand,        "msh/command/show_mshrc_command"
    autoload :ShowConfigCommand,       "msh/command/show_config_command"
    autoload :ShowModuleCommand,       "msh/command/show_module_command"
    autoload :ShowRequestCommand,      "msh/command/show_request_command"
    autoload :ShowMonitorCommand,      "msh/command/show_monitor_command"
    autoload :ShowUserCommand,         "msh/command/show_user_command"
    autoload :ShowSaCommand,           "msh/command/show_sa_command"
    autoload :ShowSaGroupCommand,      "msh/command/show_sagroup_command"
    autoload :ShowTemplateSetCommand,  "msh/command/show_template_set_command"
    autoload :ShowTemplateConfigCommand, "msh/command/show_template_config_command"
    autoload :ShowTemplateVariableCommand,   "msh/command/show_template_variable_command"

    autoload :SetConfigCommand,        "msh/command/set_config_command"

    autoload :SetModuleCommand,        "msh/command/set_module_command"

    autoload :AddMonitorCommand,       "msh/command/add_monitor_command"
    autoload :SetMonitorCommand,       "msh/command/set_monitor_command"
    autoload :UnsetMonitorCommand,     "msh/command/unset_monitor_command"
    autoload :DeleteMonitorCommand,       "msh/command/delete_monitor_command"

    autoload :SetSaCommand,            "msh/command/set_sa_command"
    autoload :UnsetSaCommand,          "msh/command/unset_sa_command"

    autoload :AddSaGroupCommand,       "msh/command/add_sagroup_command"
    autoload :SetSaGroupCommand,       "msh/command/set_sagroup_command"
    autoload :UnsetSaGroupCommand,     "msh/command/unset_sagroup_command"
    autoload :DeleteSaGroupCommand,       "msh/command/delete_sagroup_command"

    autoload :AddTemplateSetCommand,   "msh/command/add_template_set_command"
    autoload :SetTemplateSetCommand,   "msh/command/set_template_set_command"
    autoload :UnsetTemplateSetCommand,   "msh/command/unset_template_set_command"
    autoload :DeleteTemplateSetCommand,   "msh/command/delete_template_set_command"

    autoload :SetTemplateConfigCommand,   "msh/command/set_template_config_command"
    autoload :DeleteTemplateConfigCommand,   "msh/command/delete_template_config_command"

    autoload :AddTemplateVariableCommand,   "msh/command/add_template_variable_command"
    autoload :SetTemplateVariableCommand,   "msh/command/set_template_variable_command"
    autoload :DeleteTemplateVariableCommand,   "msh/command/delete_template_variable_command"

    autoload :ShowEnvCommand,          "msh/command/show_env_command"
    autoload :SetEnvCommand,           "msh/command/set_env_command"
    autoload :UnsetEnvCommand,         "msh/command/unset_env_command"

    autoload :SetMshrcCommand,         "msh/command/set_mshrc_command"

    autoload :DoExitCommand,           "msh/command/do_exit_command"
    autoload :UnknownCommandCommand,   "msh/command/unknown_command_command"
    autoload :TestCommand,              "msh/command/test_command"
  end
end
