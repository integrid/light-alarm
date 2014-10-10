class Arduino
  def self.send_message(message)
    SerialPort.open('/dev/ttyACM0', baud: 9600) do |sp|
      puts "  SENDING: #{message}"
      sp.puts(message)
      sleep(0.5)
    end
  end
end
