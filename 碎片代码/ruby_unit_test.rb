require 'test/unit'

class EemptyTest < Test::Unit::TestCase

  def setup
    @ab= ''
  end

  def test_empty_on_string
    assert  @ab.empty?
  end

end
