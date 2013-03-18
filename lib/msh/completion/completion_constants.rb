# -*- coding: utf-8 -*-
module Msh
  module Completion
    module CompletionTable


      TOP_COMPLETION_TABLE ={
        "ping"         => :PING_COMPLETION_TABLE,
        "traceroute"   => :TRACEROUTE_COMPLETION_TABLE,
        "read-storage" => :READ_STORAGE_COMPLETION_TABLE,
        "reboot"       => :REBOOT_COMPLETION_TABLE,
        "read-status"  => :READ_STATUS_COMPLETION_TABLE,
        "clear-status" => :CLEAR_STATUS_COMPLETION_TABLE,
        "md-command"   => :MD_COMMAND_COMPLETION_TABLE,
        "show"         => :SHOW_COMPLETION_TABLE,
        "quit"         => :EXIT_COMPLETION_TABLE,
        "exit"         => :EXIT_COMPLETION_TABLE,
        "help"         => :HELP_COMPLETION_TABLE,
        "add" => :ADD_COMPLETION_TABLE,
        "set" => :SET_COMPLETION_TABLE,
        "unset" => :UNSET_COMPLETION_TABLE,
        "delete" => :DELETE_COMPLETION_TABLE,
      }

      SET_COMPLETION_TABLE ={
        :'\Aset\z' => ['config', 'monitor', 'sa', 'sagroup', 'template-set', 'template-variable', 'template-config', 'module', 'env', 'mshrc'],

        # set config
        :'\Aset\s+config\z'                                                         => :GET_SA,
        :'\Aset\s+config\s+[^\s]+\z'                                               => ["working", "running", "startup"],
        :'\Aset\s+config\s+[^\s]+\s+(running|startup)\z'                          => ["(Enter)", "　"],
        :'\Aset\s+config\s+[^\s]+\s+working\z'                                     => ["module"],
        :'\Aset\s+config\s+[^\s]+\s+working\s+module\z'                            => ["<Module ID>", "　"],
        :'\Aset\s+config\s+[^\s]+\s+working\s+module\s+[^\s]+\z'                   => ["config", "(Enter)"],
        :'\Aset\s+config\s+[^\s]+\s+working\s+module\s+[^\s]+\s+config\z'          => ["<Config PATH>", "　"],
        :'\Aset\s+config\s+[^\s]+\s+working\s+module\s+[^\s]+\s+config\s+[^\s]+\z' => ["(Enter)", "　"],

        # set monitor
        :'\Aset\s+monitor\z'                                                                               => :GET_MONITOR,
        :'\Aset\s+monitor\s+[^\s]+\z'                                                                      => ["name", "reports", "sa"],
        :'\Aset\s+monitor\s+[^\s]+(\s+(reports(\s+[^\s]+){1,5}|name\s+((["\'])([^\5]+?)\5|([^\s]+))|sa(\s+[^\s]+){1,})){1,3}\z'   =>  :MONITOR_OPTION_COMPLETION,
#        :'\Aset\s+monitor\s+[^\s]+(\s+(reports(\s+[^\s]+){1,5}|name\s+[^\s]+|sa(\s+[^\s]+){1,})){1,3}\z'   =>  :MONITOR_OPTION_COMPLETION,
        :'\Aset\s+monitor\s+[^\s]+(\s+(reports(\s+[^\s]+){1,5}|name\s+((["\'])([^\5]+?)\5|([^\s]+)))){0,2}\s+sa\z'                => ["<SA>", "　"],
        :'\Aset\s+monitor\s+[^\s]+(\s+(reports(\s+[^\s]+){1,5}|name\s+((["\'])([^\5]+?)\5|([^\s]+)))){0,2}\s+sa(\s+(?!reports|name)[^\s]+){1,}\z' => :MONITOR_SA_OPTION_COMPLETION,
        :'\Aset\s+monitor\s+[^\s]+(\s+(sa(\s+[^\s]+){1,}|name\s+((["\'])([^\5]+?)\5|([^\s]+)))){0,2}\s+reports\z'                 => ["<Mail>", "　"],
        :'\Aset\s+monitor\s+[^\s]+(\s+(sa(\s+[^\s]+){1,}|name\s+((["\'])([^\5]+?)\5|([^\s]+)))){0,2}\s+reports(\s+(?!sa|name)[^\s]+){1,4}\z' => :MONITOR_REPORTS_OPTION_COMPLETION,
        :'\Aset\s+monitor\s+[^\s]+(\s+(reports(\s+[^\s]+){1,5}|sa(\s+[^\s]+){1,})){0,2}\s+name\z'          => ["<Name>", "　"],
#        :'\Aset\s+monitor\s+[^\s]+(\s+(reports(\s+[^\s]+){1,5}|sa(\s+[^\s]+){1,})){0,2}\s+name\z'          => ["<Name>", "　"],


        # set sa
        :'\Aset\s+sa\z'                                                                            => :GET_SA,
        :'\Aset\s+sa\s+[^\s]+\z'                                                                   => ["name", "description", "distributionid", "preferredpushmethod"],
        :'\Aset\s+sa\s+[^\s]+(\s+(name|description|distributionid|preferredpushmethod)\s+((["\'])([^\4]+?)\4|[^\s]+)){1,4}\z'   => :SA_OPTION_COMPLETION,
        :'\Aset\s+sa\s+[^\s]+(\s+(description|distributionid|preferredpushmethod)\s+((["\'])([^\4]+?)\4|[^\s]+)){0,3}\s+name\z' => ["<Name>", "　"],
        :'\Aset\s+sa\s+[^\s]+(\s+(name|distributionid|preferredpushmethod)\s+((["\'])([^\4]+?)\4|[^\s]+)){0,3}\s+description\z' => ["<Description>", "　"],
        :'\Aset\s+sa\s+[^\s]+(\s+(name|description|preferredpushmethod)\s+((["\'])([^\4]+?)\4|[^\s]+)){0,3}\s+distributionid\z' => ["<Distribution ID>", "　"],
        :'\Aset\s+sa\s+[^\s]+(\s+(name|description|distributionid)\s+((["\'])([^\4]+?)\4|[^\s]+)){0,3}\s+preferredpushmethod\z' => ["<Preferred Push Method>", "　"],

        # set sagroup
        :'\Aset\s+sagroup\z' => :GET_SAGROUP,
        :'\Aset\s+sagroup\s+[^\s]+\z' => ["name", "sa"],
        :'\Aset\s+sagroup\s+[^\s]+\s+sa\z' => :GET_SA,
        :'\Aset\s+sagroup\s+[^\s]+\s+sa(\s+[^\s]+)+\z' => ["name", "<SA Code>", "(Enter)"],
        :'\Aset\s+sagroup\s+[^\s]+\s+name\s+((["\'])([^\2]+?)\2|[^\s]+)\s+sa\z' => :GET_SA,
#        :'\Aset\s+sagroup\s+[^\s]+\s+name\s+((["\'])([^\2]+?)\2|[^\s]+)\s+sa(\s+[^\s]+)+\z' => ["<SA Code>", "(Enter)"],
        :'\Aset\s+sagroup\s+[^\s]+\s+name\s+((["\'])([^\2]+?)\2|[^\s]+)\s+sa(\s+[^\s]+)+\z' => :GET_SA_WITH_ENTER,
        :'\Aset\s+sagroup\s+[^\s]+\s+name\z' => ["<SA Group Name>", "　"],
        :'\Aset\s+sagroup\s+[^\s]+\s+name\s+((["\'])([^\2]+?)\2|[^\s]+)\z' => ["sa", "(Enter)"],
        :'\Aset\s+sagroup\s+[^\s]+\s+sa(\s+[^\s]+)+?\s+name\z' => ["<SA Group Name>", "　"],
        :'\Aset\s+sagroup\s+[^\s]+\s+sa(\s+[^\s]+)+?\s+name\s+((["\'])([^\3]+?)\3|[^\s]+)\z' => ["(Enter)", "　"],

        # set template-set
#        :'\Aset\s+template-set\z' => ["<TemplateSet ID>", "　"],
        :'\Aset\s+template-set\z' => :GET_TEMPLATE,
        :'\Aset\s+template-set\s+[^\s]+\z' => ["sa", "name", "csv"],

        :'\Aset\s+template-set\s+[^\s]+\s+csv\z' => ["<CSV Path>", "　"],
        :'\Aset\s+template-set\s+[^\s]+\s+csv\s+[^\s]+\z' => ["(Enter)", "　"],
#        :'\Aset\s+template-set\s+[^\s]+\s+sa\z' => ["<SA>", "　"],
        :'\Aset\s+template-set\s+[^\s]+\s+sa\z' => :GET_SA,
        :'\Aset\s+template-set\s+[^\s]+\s+sa(\s+[^\s]+){1,}\z' => :TEMPLATE_SET_OPTION_COMPLETION,
        :'\Aset\s+template-set\s+[^\s]+\s+sa(\s+[^\s]+)+\s+name\z' => ["<Name>", "　"],
        :'\Aset\s+template-set\s+[^\s]+\s+sa(\s+[^\s]+)+\s+name\s+[^\s]+\z'   => ["(Enter)", "　"],
        :'\Aset\s+template-set\s+[^\s]+\s+name\z' => ["<Name>", "　"],
        :'\Aset\s+template-set\s+[^\s]+\s+name\s+[^\s]+\z' => ["sa", "(Enter)"],
        :'\Aset\s+template-set\s+[^\s]+\s+name\s+[^\s]+\s+sa\z' => ["<SA>", "　"],
        :'\Aset\s+template-set\s+[^\s]+\s+name\s+[^\s]+\s+sa(\s+[^\s]+){1,}\z' => ["<SA>", "(Enter)"],
        :'\Aset\s+template-set\s+[^\s]+\s+name\s+[^\s]+\s+sa(\s+[^\s]){1,}\z' => ["<SA>", "(Enter)"],

        # set template-variable
#        :'\Aset\s+template-variable\z' => ["<Templateset ID>", "　"],
        :'\Aset\s+template-variable\z' => :GET_TEMPLATE,
#        :'\Aset\s+template-variable\s+[^\s]+\z' => ["<Templateset Name>", "　"],
        :'\Aset\s+template-variable\s+[^\s]+\z' => :GET_TEMPLATE_VARIABLE,
        :'\Aset\s+template-variable(\s+[^\s]+){2}\z' => ["defaultvalue", "values"],
        :'\Aset\s+template-variable(\s+[^\s]+){2}\s+defaultvalue\z' => ["<default Value>", "　"],
        :'\Aset\s+template-variable(\s+[^\s]+){2}\s+values\z' => :GET_SA,
        :'\Aset\s+template-variable(\s+[^\s]+){2}\s+values((\s+[^\s]+){2})+\z' => ["<SA Code>", "defaultvalue", "(Enter)"],
        :'\Aset\s+template-variable(\s+[^\s]+){2}\s+values((\s+[^\s]+){2}){0,}\s+[^\s]+\z' => ["<Value>", "　"],
        :'\Aset\s+template-variable(\s+[^\s]+){2}\s+values((\s+[^\s]+){2})+\s+defaultvalue\z' => ["<default Value>", "　"],


        # set template-config
        :'\Aset\s+template-config\z' => :GET_TEMPLATE,
        :'\Aset\s+template-config\s+[^\s]+\z' => ["<Module ID>", "　"],
        :'\Aset\s+template-config(\s+[^\s]+){2}\z' => ["config", "(Enter)"],
        :'\Aset\s+template-config(\s+[^\s]+){2}\s+config\z' => ["<Config PATH>", "　"],
        :'\Aset\s+template-config(\s+[^\s]+){2}\s+config\s+[^\s]+\z' => ["(Enter)", "　"],

        # set module
#        :'\Aset\s+module\z' => ['<SA Code>', '　'],
        :'\Aset\s+module\z' => :GET_SA,
        :'\Aset\s+module\s+[^\s]+\z' => ['<Module ID>', '　'],
        :'\Aset\s+module(\s+[^\s]+){2}\z' => ['<Version>', '　'],
        :'\Aset\s+module(\s+[^\s]+){3}\z' => ['(Enter)', '　'],

        # set env
        :'\Aset\s+env\z'                                                                          => ["access_key", "access_key_secret", "domain", "path", "user_code", "proxy_addr", "proxy_port", "ssl_verify", "offset_minute"],
        :'\Aset\s+env(\s+[^\s]+\s+[^\s]+){1,9}\z'                                                 => :ENV_OPTION_COMPLETION,

        :'\Aset\s+env(\s+(access_key_secret|domain|path|user_code|proxy_addr|proxy_port|ssl_verify|offset_minute)\s+[^\s]+){0,7}\s+access_key\z' => ["<access_key>", "　"],
        :'\Aset\s+env(\s+(access_key|domain|path|user_code|proxy_addr|proxy_port|ssl_verify|offset_minute)\s+[^\s]+){0,7}\s+access_key_secret\z' => ["<access_key_secret>", "　"],
        :'\Aset\s+env(\s+(access_key|access_key_secret|path|user_code|proxy_addr|proxy_port|ssl_verify|offset_minute)\s+[^\s]+){0,7}\s+domain\z' => ["<domain>", "　"],
        :'\Aset\s+env(\s+(access_key|access_key_secret|domain|user_code|proxy_addr|proxy_port|ssl_verify)\s+[^\s]+){0,7}\s+path\z' => ["<path>", "　"],
        :'\Aset\s+env(\s+(access_key|access_key_secret|domain|path|proxy_addr|proxy_port|ssl_verify|offset_minute)\s+[^\s]+){0,7}\s+user_code\z' => ["<user_code>", "　"],
        :'\Aset\s+env(\s+(access_key|access_key_secret|domain|path|user_code|proxy_port|ssl_verify|offset_minute)\s+[^\s]+){0,7}\s+proxy_addr\z' => ["<proxy_addr>", "　"],
        :'\Aset\s+env(\s+(access_key|access_key_secret|domain|path|user_code|proxy_addr|ssl_verify|offset_minute)\s+[^\s]+){0,7}\s+proxy_port\z' => ["<proxy_port>", "　"],
        :'\Aset\s+env(\s+(access_key|access_key_secret|domain|path|user_code|proxy_addr|proxy_port|offset_minute)\s+[^\s]+){0,7}\s+ssl_verify\z' => ["true", "false"],
        :'\Aset\s+env(\s+(access_key|access_key_secret|domain|path|user_code|proxy_addr|proxy_port|ssl_verify)\s+[^\s]+){0,7}\s+offset_minute\z' => ["<-720 - 840>", "　"],


        # set mshrc
#        :'\Aset\s+mshrc\z' => ["mshrc"],
        :'\Aset\s+mshrc\z' => :MSHRC_COMPLETION,
        :'\Aset\s+mshrc\s+[^\s]+\z' => ["(Enter)", "　"],

      }

      UNSET_COMPLETION_TABLE ={
        "unset" => ['monitor', 'sa', 'sagroup', 'template-set', 'env'],

        # unset monitor
        :'\Aunset\s+monitor\z'                                                                             => :GET_MONITOR,
        :'\Aunset\s+monitor\s+[^\s]+\z'                                                                    => ["name", "reports", "sa"],
        :'\Aunset\s+monitor\s+[^\s]+(\s+[^\s]+){1,3}\z'                                                    => :MONITOR_OPTION_COMPLETION,

        # unset sa
        :'\Aunset\s+sa\z'                                                                          => :GET_SA,
        :'\Aunset\s+sa\s+[^\s]+\z'                                                                 => ["name", "description", "distributionid", "preferredpushmethod"],
        :'\Aunset\s+sa\s+[^\s]+(\s+(name|description|distributionid|preferredpushmethod)){1,4}\z'          => :SA_OPTION_COMPLETION,


        # unset sagroup
        :'\Aunset\s+sagroup\z' => :GET_SAGROUP,
        :'\Aunset\s+sagroup\s+[^\s]+\z' => ["name", "sa"],
        :'\Aunset\s+sagroup\s+[^\s]+\s+name\z' => ["(Enter)", "sa"],
        :'\Aunset\s+sagroup\s+[^\s]+\s+sa\z' => ["(Enter)", "name"],
        :'\Aunset\s+sagroup\s+[^\s]+\s+name\s+sa\z' => ["(Enter)", "　"],
        :'\Aunset\s+sagroup\s+[^\s]+\s+sa\s+name\z' => ["(Enter)", "　"],


        # unset template-set
#        :'\Aunset\s+template-set\z' => ["<Templateset ID>", "　"],
        :'\Aunset\s+template-set\z' => :GET_TEMPLATE,
        :'\Aunset\s+template-set\s+[^\s]+\z' => ["sa", "name"],
        :'\Aunset\s+template-set\s+[^\s]+\s+sa\z' => ["name", "(Enter)"],
        :'\Aunset\s+template-set\s+[^\s]+\s+name\z' => ["sa", "(Enter)"],
        :'\Aunset\s+template-set\s+[^\s]+(\s+(sa|name)){2}\z' => ["(Enter)", "　"],

        # unset env
        :'\Aunset\s+env\z'                                                                        => ["access_key", "access_key_secret", "domain", "path", "user_code", "proxy_addr", "proxy_port", "ssl_verify", "offset_minute"],
        :'\Aunset\s+env(\s+(access_key|access_key_secret|domain|path|user_code|proxy_addr|proxy_port|ssl_verify|offset_minute)){1,9}\z'          => :ENV_OPTION_COMPLETION,
      }


      ADD_COMPLETION_TABLE ={
        "add" => ['monitor', 'sagroup', 'template-set', 'template-variable'],

        #monitor
        :'\Aadd\s+monitor\z'                                                                               => ["<Monitor Name>", "　"],
#        :'\Aadd\s+monitor\s+[^\s]+\z'                                                                     => ["(Enter)", "　"],
        :'\Aadd\s+monitor\s+((["\'])([^\2]+?)\2|([^\s]+))\z'                                                                     => ["(Enter)", "　"],

        #sagroup
        :'\Aadd\s+sagroup\z'                                                                            => ["<SA Group Name>", "　"],
        :'\Aadd\s+sagroup\s+((["\'])([^\2]+?)\2|([^\s]+))\z'                                                                            => ["(Enter)", "　"],

        #template-set
        :'\Aadd\s+template-set\z' => ["<TemplateSet Name>", "　"],
        :'\Aadd\s+template-set\s+[^\s]+\z' => ["(Enter)", "　"],

        #template-variable
#        :'\Aadd\s+template-variable\z' => ["<TemplateSet ID>", "　"],
        :'\Aadd\s+template-variable\z' => :GET_TEMPLATE,
        :'\Aadd\s+template-variable\s+[^\s]+\z' => ["<TemplateVariable Name>", "　"],
        :'\Aadd\s+template-variable(\s+[^\s]+){2}\z' => ["defaultvalue", "(Enter)"],
        :'\Aadd\s+template-variable(\s+[^\s]+){2}\s+defaultvalue\z' => ["<Default Value>", "　"],
        :'\Aadd\s+template-variable(\s+[^\s]+){2}\s+defaultvalue\s+[^\s]+\z' => ["(Enter)", "　"],


      }

      DELETE_COMPLETION_TABLE ={
        "delete" => ['monitor', 'sagroup', 'template-set', 'template-variable', 'template-config'],

        # delete monitor
        :'\Adelete\s+monitor\z'                                                                               => :GET_MONITOR,
        :'\Adelete\s+monitor+\s+[^\s]+\z'                                                                     => ["(Enter)", "　"],

        # delete sagroup
#        :'\Adelete\s+sagroup\z'                                                                            => ["<SA Group Name>", "　"],
        :'\Adelete\s+sagroup\z'                                                                            => :GET_SAGROUP,
        :'\Adelete\s+sagroup+\s+[^\s]+\z'                                                                     => ["(Enter)", "　"],

        # delete template-set

        # delete template-variable
#        :'\Adelete\s+template-variable\z' => ["<TemplateSet ID>", "　"],
        :'\Adelete\s+template-variable\z' => :GET_TEMPLATE,
#        :'\Adelete\s+template-variable\s+[^\s]+\z' => ["<TemplateSet Name>", "　"],
        :'\Adelete\s+template-variable\s+[^\s]+\z' => :GET_TEMPLATE_VARIABLE,
        :'\Adelete\s+template-variable(\s+[^\s]+){2}\z' => ["(Enter)", "　"],

        # delete template-config
#        :'\Adelete\s+template-config\z' => ["<TemplateSet ID>", "　"],
        :'\Adelete\s+template-config\z' => :GET_TEMPLATE,
        :'\Adelete\s+template-config\s+[^\s]+\z' => ["<Module ID>", "　"],
        :'\Adelete\s+template-config(\s+[^\s]+){2}\z' => ["(Enter)", "　"],

        # delete template-set
#        :'\Adelete\s+template-set\z' => ["<TemplateSet ID>", "　"],
        :'\Adelete\s+template-set\z' => :GET_TEMPLATE,
        :'\Adelete\s+template-set\s+[^\s]+\z' => ["(Enter)", "　"],

      }

      HELP_COMPLETION_TABLE = {
        :'\Ahelp\z'                                                                                                                     =>
        ["ping", "traceroute", "read-storage", "reboot", "read-status", "clear-status", "md-command", "show", "add", "set", "unset", "delete", "(Enter)"],
        :'\Ahelp\s+show\z'                                                                                                              => [ "config", "env", "event", "module", "monitor", "mshrc", "request", "sa", "sagroup", "template-set", "template-variable", "template-config", "user", "(Enter)"],
        :'\Ahelp\s+set\z'                                                                                                              => [ "config", "env", "event", "module", "monitor", "mshrc", "sa", "sagroup", "template-config", "template-set", "template-variable", "(Enter)"],
        :'\Ahelp\s+unset\z'                                                                                                              => ["env", "monitor", "sa", "sagroup", "template-set", "(Enter)"],
        :'\Ahelp\s+delete\z'                                                                                                              => ["monitor", "sagroup", "template-config", "template-set", "template-variable", "(Enter)"],
        :'\Ahelp\s+config\z'                                                                                                            => ["set", "(Enter)"],
        :'\Ahelp\s+monitor\z'                                                                                                           => ["add", "del", "set", "unset", "(Enter)"],
        :'\Ahelp\s+sa\z'                                                                                                                => ["set", "unset", "(Enter)"],
        :'\Ahelp\s+env\z'                                                                                                               => ["set", "unset", "(Enter)"],
        :'\Ahelp\s+((ping|traceroute|read-storage|reboot|read-status|clear-status|smd-command)|(show|config|monitor|sa|env)\s+[^\s]+)\z' => ["(Enter)", "　"],
      }

      EXIT_COMPLETION_TABLE = {
        :'\A(quit|exit)\z' => ["(Enter)", "　"],
      }

      PING_COMPLETION_TABLE = {
        :'\Aping\z'                                                                           => :GET_SA,
        :'\Aping\s+[^\s]+\z'                                                                  => ["<IP Address>", "　"],
        :'\Aping(\s+[^\s]+){2}\z'                                                             => ["targettime", "count", "size", "(Enter)"],
        :'\Aping(\s+[^\s]+){2}\s+((count|size)\s+[^\s]+\s+){0,2}targettime(\s+[^\s]+){0,1}\z' => ["<targetTime>", "　"],
        :'\Aping(\s+[^\s]+){2}\s+(size\s+[^\s]+\s+|targettime(\s+[^\s]+){2}\s+){0,2}count\z'  => ["<count>", "　"],
        :'\Aping(\s+[^\s]+){2}\s+(count\s+[^\s]+\s+|targettime(\s+[^\s]+){2}\s+){0,2}size\z'  => ["<size>", "　"],
        :'\Aping(\s+[^\s]+){2}(\s+(count|size)\s+[^\s]+|\s+targettime(\s+[^\s]+){2}){1,3}\z'  => :PING_OPTION_COMPLETION
      }

      TRACEROUTE_COMPLETION_TABLE = {
        :'\Atraceroute\z'                                                                             => :GET_SA,
        :'\Atraceroute\s+[^\s]+\z'                                                                    => ["<IP Address>", "　"],
        :'\Atraceroute\s+[^\s]+\s+[^\s]+\z'                                                           => ["targettime", "count", "maxhop", "(Enter)"],
        :'\Atraceroute(\s+[^\s]+){2}\s+((count|maxhop)\s+[^\s]+\s+){0,2}targettime(\s+[^\s]+){0,1}\z' => ["<targetTime>", "　"],
        :'\Atraceroute(\s+[^\s]+){2}\s+(count\s+[^\s]+\s+|targettime(\s+[^\s]+){2}\s+){0,2}maxhop\z'  => ["<maxHop>", "　"],
        :'\Atraceroute(\s+[^\s]+){2}\s+(maxhop\s+[^\s]+\s+|targettime(\s+[^\s]+){2}\s+){0,2}count\z'  => ["<count>", "　"],
        :'\Atraceroute(\s+[^\s]+){2}(\s+(count|maxhop)\s+[^\s]+|\s+targettime(\s+[^\s]+){2}){1,3}\z'  => :TRACEROUTE_OPTION_COMPLETION
      }

      READ_STORAGE_COMPLETION_TABLE = {
        :'\Aread-storage\z'                                                                  => :GET_SA,
        :'\Aread-storage\s+[^\s]+\z'                                                         => ["startup", "running", "backup"],
        :'\Aread-storage\s+[^\s]+\s+(startup|running|backup)\z'                              => ["targettime", "(Enter)"],
        :'\Aread-storage\s+[^\s]+\s+(startup|running|backup)\s+targettime(\s+[^\s]+){0,1}\z' => ["<targetTime>", "　"],
        :'\Aread-storage\s+[^\s]+\s+(startup|running|backup)\s+targettime(\s+[^\s]+){2}\z'   => ["(Enter)", "　"],
      }

      REBOOT_COMPLETION_TABLE = {
        :'\Areboot\z'                                       => :GET_SA,
        :'\Areboot\s+[^\s]+\z'                              => ["targettime", "(Enter)"],
        :'\Areboot\s+[^\s]+\s+targettime(\s+[^\s]+){0,1}\z' => ["<targetTime>", "　"],
        :'\Areboot\s+[^\s]+\s+targettime(\s+[^\s]+){2}\z'   => ["(Enter)", "　"],
      }

      READ_STATUS_COMPLETION_TABLE = {
        :'\Aread-status\z'                                            => :GET_SA,
        :'\Aread-status\s+[^\s]+\z'                                   => ["<Module ID>", "　"],
        :'\Aread-status(\s+[^\s]+){2}\z'                              => ["<Command>", "　"],
        :'\Aread-status(\s+[^\s]+){3,}\z'                              => ["targettime","<Command>", "(Enter)"],
        :'\Aread-status(\s+[^\s]+){3,}\s+targettime(\s+[^\s]+){0,1}\z' => ["<targetTime>", "　"],
        :'\Aread-status(\s+[^\s]+){3,}\s+targettime(\s+[^\s]+){2}\z'   => ["(Enter)", "　"],
      }

      CLEAR_STATUS_COMPLETION_TABLE = {
        :'\Aclear-status\z'                                            => :GET_SA,
        :'\Aclear-status\s+[^\s]+\z'                                   => ["<Module ID>", "　"],
        :'\Aclear-status(\s+[^\s]+){2}\z'                              => ["<Command>", "　"],
        :'\Aclear-status(\s+[^\s]+){3,}\z'                              => ["targettime","<Command>", "(Enter)"],
        :'\Aclear-status(\s+[^\s]+){3,}\s+targettime(\s+[^\s]+){0,1}\z' => ["<targetTime>", "　"],
        :'\Aclear-status(\s+[^\s]+){3,}\s+targettime(\s+[^\s]+){2}\z'   => ["(Enter)", "　"],
      }

      MD_COMMAND_COMPLETION_TABLE = {
        :'\Amd-command\z'                                             => :GET_SA,
        :'\Amd-command\s+[^\s]+\z'                                    => ["<Module ID>", "　"],
        :'\Amd-command(\s+[^\s]+){2}\z'                               => ["<Command>", "　"],
        :'\Amd-command(\s+[^\s]+){3,}\z'                              => ["targettime","<Command>", "(Enter)"],
        :'\Amd-command(\s+[^\s]+){3,}\s+targettime(\s+[^\s]+){0,1}\z' => ["<targetTime>", "　"],
        :'\Amd-command(\s+[^\s]+){3,}\s+targettime(\s+[^\s]+){2}\z'   => ["(Enter)", "　"],
      }

      SHOW_COMPLETION_TABLE = {
        :'\Ashow\z'                                                         => ["event", "config", "request", "monitor", "user", "sa", "sagroup", "template-set", "template-variable", "template-config", "module", "env", "mshrc"],

        :'\Ashow\s+event(\s+(sa|type)\s+[^\s]+){0,2}\z'                     => :SHOW_EVENT_OPTION_COMPLETION,
        :'\Ashow\s+event\s+(type\s+[^\s]+\s+){0,1}sa\z'                     => :GET_SA,
        :'\Ashow\s+event\s+(sa\s+[^\s]+\s+){0,1}type\z'                     => ["configure", "monitor", "request"],

        :'\Ashow\s+config\z'                                                => :GET_SA,
        :'\Ashow\s+config\s+[^\s]+\z'                                       => ["type", "(Enter)"],
        :'\Ashow\s+config\s+[^\s]+\s+type\z'                                => ["working", "preview", "running", "startup"],
        :'\Ashow\s+config\s+[^\s]+\s+type\s+[^\s]+\z'                       => ["module", "(Enter)"],
        :'\Ashow\s+config\s+[^\s]+\s+type\s+[^\s]+\s+module\z'              => ["<Module ID>", "　"],
        :'\Ashow\s+config\s+[^\s]+\s+type\s+[^\s]+\s+module\s+[^\s]+\z'     => ["(Enter)", "　"],
        :'\Ashow\s+config\s+[^\s]+\s+type\s+preview\z'     => ["module"],

        :'\Ashow\s+request(\s+(sa\s+[^\s]+|status(\s+[^\s]+){1,9})){0,2}\z' => :SHOW_REQUEST_OPTION_COMPLETION,
        :'\Ashow\s+request\s+(status(\s+[^\s]+){1,9}\s+){0,1}sa\z'          => :GET_SA,
        :'\Ashow\s+request\s+(sa\s+[^\s]+\s+){0,1}status\z'                 => ["<Status>", "　"],
        :'\Ashow\s+request\s+(sa\s+[^\s]+\s+){0,1}status(\s+[^\s]+){1,8}\z' => ["type", "<Status>", "(Enter)"],
        :'\Ashow\s+request\s+.*type\z'                 => ["ping", "traceroute", "read-storage", "reboot", "read-status", "clear-status", "md-command"],
        :'\Ashow\s+request\s+.*type\s+(ping|traceroute|read-storage|reboot|read-status|clear-status|md-command)\z' => ["id", "(Enter)"],
        :'\Ashow\s+request\s+.*type\s+(ping|traceroute|read-storage|reboot|read-status|clear-status|md-command)\s+id\z' => ["<Request ID>", "　"],
        :'\Ashow\s+request\s+.*type\s+(ping|traceroute|read-storage|reboot|read-status|clear-status|md-command)\s+id\s+[^\s]+\z' => ["(Enter)", "　"],

        :'\Ashow\s+monitor\z'                                               => :GET_MONITOR_WITH_ENTER,
        :'\Ashow\s+monitor\s+[^\s]+\z'                                      => ["(Enter)", "　"],

        :'\Ashow\s+user\z'                                                  => ["(Enter)", "　"],

        :'\Ashow\s+sa\z'                                                    => :GET_SA_WITH_ENTER,
        :'\Ashow\s+sa\s+[^\s]+\z'                                           => ["(Enter)", "　"],

        :'\Ashow\s+sagroup\z'                                               => :GET_SAGROUP_WITH_ENTER,
        :'\Ashow\s+sagroup\s+[^\s]+\z'                                      => ["(Enter)", "　" ],

        :'\Ashow\s+template-set\z'                                          => ["id", "(Enter)"],
        :'\Ashow\s+template-set\s+id\z'                                          => :GET_TEMPLATE_WITH_ENTER,
        :'\Ashow\s+template-set\s+id\s+[^\s]+\z'                                  => ["(Enter)", "csv"],
        :'\Ashow\s+template-set\s+id\s+[^\s]+\s+csv\z'                                  => ["(Enter)", "　"],

        :'\Ashow\s+template-variable\z'                                => :GET_TEMPLATE,
        :'\Ashow\s+template-variable\s+[^\s]+\z'                       => ["name", "(Enter)"],
        :'\Ashow\s+template-variable\s+[^\s]+\s+[^\s]+\z'                       => :GET_TEMPLATE_VARIABLE_WITH_ENTER,
        :'\Ashow\s+template-variable\s+[^\s]+\s+[^\s]+\s+[^\s]+\z'              => ["(Enter)", "　"],

        :'\Ashow\s+template-config\z'                                => :GET_TEMPLATE,
        :'\Ashow\s+template-config\s+[^\s]+\z'                       => ["<Module ID>", "(Enter)"],
        :'\Ashow\s+template-config\s+[^\s]+\s+[^\s]+\z'              => ["(Enter)", "　"],

        :'\Ashow\s+module\z' => ['(Enter)', "　"],

        :'\Ashow\s+env\z'                                                   => ["(Enter)", "　"],

        :'\Ashow\s+mshrc\z'                                                   => :MSHRC_COMPLETION,
        :'\Ashow\s+mshrc\s+[^\s]+\z'                                                   => ["(Enter)", "　"],



      }

    end

    module OptionCompletionProcs
      MSHRC_DIR_PATH = "#{ENV["HOME"]}/.msh/"

      PING_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["targettime", "count", "size", "(Enter)"]

        candidate_table -= ["targettime"] if splited_buffer.include?("targettime")
        candidate_table -= ["count"]      if splited_buffer.include?("count")
        candidate_table -= ["size"]       if splited_buffer.include?("size")

        candidate_table << "　"           if candidate_table.size <= 1
        candidate_table
      }

      TRACEROUTE_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["targettime", "count", "maxhop", "(Enter)"]

        candidate_table -= ["targettime"] if splited_buffer.include?("targettime")
        candidate_table -= ["maxhop"]     if splited_buffer.include?("maxhop")
        candidate_table -= ["count"]      if splited_buffer.include?("count")

        candidate_table << "　"           if candidate_table.size <= 1
        candidate_table
      }

      SHOW_EVENT_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["sa", "type", "(Enter)"]

        candidate_table -= ["sa"]   if splited_buffer.include?("sa")
        candidate_table -= ["type"] if splited_buffer.include?("type")

        candidate_table << "　"     if candidate_table.size <= 1
        candidate_table
      }

      SHOW_REQUEST_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["sa", "status", "type", "(Enter)"]

        candidate_table -= ["sa"]     if splited_buffer.include?("sa") && @line_buffer !~ /sa$/
        candidate_table -= ["status"] if splited_buffer.include?("status")
        candidate_table -= ["type"] if splited_buffer.include?("type")

        candidate_table << "　"       if candidate_table.size <= 1
        candidate_table
      }

      MONITOR_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["name", "reports", "sa", "(Enter)"]

        candidate_table -= ["name"]    if splited_buffer.include?("name")
        candidate_table -= ["sa"]      if splited_buffer.include?("sa") && @line_buffer !~ /sa$/
        candidate_table -= ["reports"] if splited_buffer.include?("reports")

        candidate_table << "　"        if candidate_table.size <= 1
        candidate_table
      }

      MONITOR_REPORTS_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["name", "sa", "<Mail>", "(Enter)"]
        candidate_table -= ["name"] if splited_buffer.include?("name")
        candidate_table -= ["sa"]   if splited_buffer.include?("sa") && @line_buffer !~ /sa$/
        candidate_table << "　"     if candidate_table.size <= 1
        candidate_table
      }

      MONITOR_SA_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["name", "reports", "<SA>", "(Enter)"]

        candidate_table -= ["name"]    if splited_buffer.include?("name")
        candidate_table -= ["reports"] if splited_buffer.include?("reports")

        candidate_table << "　"        if candidate_table.size <= 1
        candidate_table
      }

      SA_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["name", "description", "distributionid", "preferredpushmethod", "(Enter)"]

        candidate_table -= ["name"]                if splited_buffer.include?("name")
        candidate_table -= ["description"]         if splited_buffer.include?("description")
        candidate_table -= ["distributionid"]              if splited_buffer.include?("distributionid")
        candidate_table -= ["preferredpushmethod"] if splited_buffer.include?("preferredpushmethod")

        candidate_table << "　"                    if candidate_table.size <= 1
        candidate_table
      }

      TEMPLATE_SET_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["name", "(Enter)"]
 
        candidate_table += GET_SA.call

        candidate_table -= ["name"]                if splited_buffer.include?("name")

        candidate_table << "　"                    if candidate_table.size <= 1
        candidate_table
      }


      ENV_OPTION_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = ["access_key", "access_key_secret", "domain", "path", "user_code", "proxy_addr", "proxy_port", "ssl_verify", "offset_minute", "(Enter)"]

        candidate_table -= ["access_key"]       if splited_buffer.include?("access_key") && @line_buffer !~ /key$/
        candidate_table -= ["access_key_secret"] if splited_buffer.include?("access_key_secret")
        candidate_table -= ["domain"]    if splited_buffer.include?("domain")
        candidate_table -= ["path"]      if splited_buffer.include?("path")
        candidate_table -= ["user_code"]      if splited_buffer.include?("user_code")
        candidate_table -= ["proxy_addr"] if splited_buffer.include?("proxy_addr")
        candidate_table -= ["proxy_port"] if splited_buffer.include?("proxy_port")
        candidate_table -= ["ssl_verify"] if splited_buffer.include?("ssl_verify")
        candidate_table -= ["offset_minute"] if splited_buffer.include?("offset_minute")

        candidate_table << "　" if candidate_table.size <= 1
        candidate_table
      }

      MSHRC_COMPLETION = Proc.new { |splited_buffer|
        candidate_table = Dir.entries(MSHRC_DIR_PATH).grep(/\Amshrc(\z|\.)/).grep(/#{splited_buffer[-1]}/)
        candidate_table << "(Enter)" if splited_buffer[0] == "show"

        candidate_table
      }

      GET_SA = Proc.new do |a|
        if $cache.sa_code.nil? || $cache.sa_code.empty?
          ret = ["<SA Code>", "　"]
        else
          ret = $cache.sa_code
        end
        ret
      end

      GET_SA_WITH_ENTER = Proc.new do |a|
        if $cache.sa_code.nil? || $cache.sa_code.empty?
          ret = ["<SA Code>",]
        else
          ret = $cache.sa_code
        end
        ret << "(Enter)"
      end


      GET_SAGROUP = Proc.new do |a|
        if $cache.sagroup_id.nil? || $cache.sagroup_id.empty?
          ret = ["<Sagroup ID>", "　"]
        else
          ret = $cache.sagroup_id
        end
        ret
      end

      GET_SAGROUP_WITH_ENTER = Proc.new do |a|
        if $cache.sagroup_id.nil? || $cache.sagroup_id.empty?
          ret = ["<Sagroup ID>"]
        else
          ret = $cache.sagroup_id
        end
        ret << "(Enter)"
      end

      GET_MONITOR = Proc.new do |a|
        if $cache.monitor_id.nil? || $cache.monitor_id.empty?
          ret = ["<Monitor ID>", "　"]
        else
          ret = $cache.monitor_id
        end
        ret
      end

      GET_MONITOR_WITH_ENTER = Proc.new do |a|
        if $cache.monitor_id.nil? || $cache.monitor_id.empty?
          ret = ["<Monitor ID>"]
        else
          ret = $cache.monitor_id
        end
        ret << "(Enter)"
      end

      GET_TEMPLATE = Proc.new do |a|
        if $cache.template_set_id.nil? || $cache.template_set_id.empty?
          ret = ["<TemplateSet ID>"]
        else
          ret = $cache.template_set_id
        end
        ret
      end

      GET_TEMPLATE_WITH_ENTER = Proc.new do |a|
        if $cache.template_set_id.nil? || $cache.template_set_id.empty?
          ret = ["<TemplateSet ID>"]
        else
          ret = $cache.template_set_id
        end
        ret << "(Enter)"
      end

      GET_TEMPLATE_VARIABLE = Proc.new do |a|
        if $cache.template_variable_name[a[-1]].nil? || $cache.template_variable_name[a[-1]].empty?
          ret = ["<TemplateVariable Name>"]
        else
          ret = $cache.template_variable_name[a[-1]]
        end
        ret
      end

      GET_TEMPLATE_VARIABLE_WITH_ENTER = Proc.new do |a|
        if $cache.template_variable_name[a[-2]].nil? || $cache.template_variable_name[a[-2]].empty?
          ret = ["<TemplateVariable Name>"]
        else
          ret = $cache.template_variable_name[a[-2]]
        end
        ret << "(Enter)"
        ret
      end

    end
  end
end

