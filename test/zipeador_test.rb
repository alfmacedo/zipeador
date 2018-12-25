require "test_helper"

class ZipeadorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Zipeador::VERSION
  end

  def test_zip_unzip
    # Zip
    zip = Zipeador.zip("filename.xml", "file")
    # UnZip
    Zipeador.unzip(zip)
    assert true
  end
end
