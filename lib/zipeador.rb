require "zipeador/version"
require 'securerandom'
require 'zip'

module Zipeador
  class Error < StandardError
  end

  def self.zip(name, file)
    begin
      stringio = Zip::OutputStream.write_buffer do |zio|
        zio.put_next_entry(name)
        zio.write(file)
      end
      stringio.rewind
      stringio.sysread
    rescue => e
      raise Error.new = e
    end
  end

  def self.unzip(file)
    begin
      filename = "#{SecureRandom.uuid}.zip"
      temp_file = Tempfile.new(filename)
      temp_file.binmode
      temp_file.write(file)
      temp_file.flush
      begin
        Zip::File.open(temp_file.path) do |zip_file|
          #Find specific entry, PDF or XML
          entry = zip_file.glob('*.xml').first || zip_file.glob('*.pdf').first
          entry.get_input_stream.read
        end
      ensure
        #Close and delete the temp file
        temp_file.close
        temp_file.unlink
      end
    rescue => e
      raise Error.new = e
    end
  end
end
