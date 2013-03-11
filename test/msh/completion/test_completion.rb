require 'test_helper'

require 'msh/completion'

def completion_test(expected_candidates, word, input)
  candidates = @completor.doit(input).grep(/\A#{Regexp.quote word}/)

  assert_kind_of(Array, candidates)
  assert_equal(expected_candidates, candidates)
end

