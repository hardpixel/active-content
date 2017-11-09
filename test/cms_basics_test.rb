require 'test_helper'

class CmsBasicsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CmsBasics::VERSION
  end
end
