module Msh
  module Constants
    REQUEST_MAX_POLL = ($conf[:poll_count].to_i if $conf[:poll_count]) || 5
    REQUEST_POLL_INTERVAL = ($conf[:request_interval].to_i if $conf[:request_interval]) || 3
    REQUEST_TARGET_TIME = nil

    HTTP_SUCCESS = /^2\d\d$/
    HTTP_OK = /^200$/
    HTTP_CREATED = /^201$/
    HTTP_NO_CONTENT = /^204$/
  end
end
