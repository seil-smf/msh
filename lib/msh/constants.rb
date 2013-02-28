module Msh
  module Constants
    REQUEST_MAX_POLL = 5
    REQUEST_POLL_INTERVAL = 3
    REQUEST_TARGET_TIME = nil

    HTTP_SUCCESS = /^2\d\d$/
    HTTP_OK = /^200$/
    HTTP_CREATED = /^201$/
    HTTP_NO_CONTENT = /^204$/
  end
end
