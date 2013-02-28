# -*- coding: utf-8 -*-

require "msh/completion/completion_constants"
require "singleton"

module Msh
  module Completion
    class Completor
      include Singleton
      include CompletionTable
      include OptionCompletionProcs

      def init(line_buffer)
        @line_buffer    = line_buffer
        @splited_buffer = line_buffer.split
        @prev_buffer    = @splited_buffer[0...-1].join(" ")
        @current_buffer = line_buffer.strip
      end

      def doit(line_buffer)
        init(line_buffer)

        return TOP_COMPLETION_TABLE.keys unless @line_buffer.lstrip =~ /^[^\s]+\s+/
        completion_table = eval(TOP_COMPLETION_TABLE[@splited_buffer[0]].to_s)
        return [] if completion_table.nil?

        candidate_table = []
        completion_table.each do | key_re, v |
          if @line_buffer =~ /.+\s$/
            fixed_buffer = @current_buffer
          else
            fixed_buffer = @prev_buffer
          end

          if fixed_buffer =~ /#{key_re}/
            if Symbol === v
              candidate_table = eval(v.to_s).call(@splited_buffer)
            else
              candidate_table = v
            end
          end

        end
        candidate_table

      end

    end
  end
end

