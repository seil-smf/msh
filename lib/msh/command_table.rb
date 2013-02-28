# -*- coding: utf-8 -*-
module Msh
  module CommandTable

    class CommandTableHash < Hash
      def initialize(hash)
        self.merge!(hash)
        self.default= Msh::Command::UnknownCommandCommand
      end
    end

    SHOW_TABLE = CommandTableHash.new({
      :event => Msh::Command::ShowEventCommand,
      :mshrc => Msh::Command::ShowMshrcCommand,
      :config => Msh::Command::ShowConfigCommand,
      :module => Msh::Command::ShowModuleCommand,
      :request => Msh::Command::ShowRequestCommand,
      :monitor => Msh::Command::ShowMonitorCommand,
      :user => Msh::Command::ShowUserCommand,
      :sa => Msh::Command::ShowSaCommand,
      :env => Msh::Command::ShowEnvCommand,
      :sagroup => Msh::Command::ShowSaGroupCommand,
      :"template-set" => Msh::Command::ShowTemplateSetCommand,
      :"template-config" => Msh::Command::ShowTemplateConfigCommand,
      :"template-variable" => Msh::Command::ShowTemplateVariableCommand,
    })

    ADD_TABLE = CommandTableHash.new({
      :sagroup => Msh::Command::AddSaGroupCommand,
      :monitor => Msh::Command::AddMonitorCommand,
      :"template-set" => Msh::Command::AddTemplateSetCommand,
      :"template-variable" => Msh::Command::AddTemplateVariableCommand,
    })

    SET_TABLE = CommandTableHash.new({
      :sagroup => Msh::Command::SetSaGroupCommand,
      :monitor => Msh::Command::SetMonitorCommand,
      :mshrc => Msh::Command::SetMshrcCommand,
      :env => Msh::Command::SetEnvCommand,
      :"template-set" => Msh::Command::DeleteTemplateSetCommand,
      :module => Msh::Command::SetModuleCommand,
      :sa => Msh::Command::SetSaCommand,
      :config => Msh::Command::SetConfigCommand,
      :"template-set" => Msh::Command::SetTemplateSetCommand,
      :"template-variable" => Msh::Command::SetTemplateVariableCommand,
      :"template-config" => Msh::Command::SetTemplateConfigCommand,
    })

    UNSET_TABLE = CommandTableHash.new({
      :sagroup => Msh::Command::UnsetSaGroupCommand,
      :monitor => Msh::Command::UnsetMonitorCommand,
      :env => Msh::Command::UnsetEnvCommand,
      :sa => Msh::Command::UnsetSaCommand,
      :"template-set" => Msh::Command::UnsetTemplateSetCommand,
    })

    DELETE_TABLE = CommandTableHash.new({
      :sagroup => Msh::Command::DeleteSaGroupCommand,
      :monitor => Msh::Command::DeleteMonitorCommand,
      :"template-set" => Msh::Command::DeleteTemplateSetCommand,
      :"template-variable" => Msh::Command::DeleteTemplateVariableCommand,
      :"template-config" => Msh::Command::DeleteTemplateConfigCommand,
    })

    TOP_TABLE = CommandTableHash.new({
      :ping => Msh::Command::PingCommand,
      :traceroute => Msh::Command::TracerouteCommand,
      :"read-storage" => Msh::Command::ReadStorageCommand,
      :reboot => Msh::Command::RebootCommand,
      :"read-status" => Msh::Command::ReadStatusCommand,
      :"clear-status" => Msh::Command::ClearStatusCommand,
      :"md-command" => Msh::Command::MdCommandCommand,
      :exit => Msh::Command::DoExitCommand,
      :quit => Msh::Command::DoExitCommand,
      :help => Msh::Command::HelpCommand,
      :show => SHOW_TABLE,
      :add => ADD_TABLE,
      :set => SET_TABLE,
      :unset => UNSET_TABLE,
      :delete => DELETE_TABLE,
      :test =>  Msh::Command::TestCommand,
    })

  end
end


