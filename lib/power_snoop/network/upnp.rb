require 'socket'

module PowerSnoop
  module Network

    class UPnP
      attr_reader :bind_host, :bind_port, :multicast_host, :multicast_port, :timeout

      def initialize(options = {})
        @bind_host = options[:host] || discover_ip
        @bind_port = options[:port] || 54321
        @multicast_host = '239.255.255.250'
        @multicast_port = 1900
        @timeout = options[:timeout] || 10

        connect_socket
      end

      def connect_socket
        puts "Binding to #{bind_host}:#{bind_port}"
        @udp_socket = UDPSocket.new
        @udp_socket.bind bind_host, bind_port
      end

      def discover_ip
        '10.0.0.61'
      end

      def ssdp_discover
        messages = []
        puts "Discovering devices"
        @udp_socket.send ssdp_discover_message, 0, multicast_host, multicast_port
        puts "Sent multicast datagram to #{multicast_host}:#{multicast_port}"

        require 'timeout'
        begin
          Timeout::timeout(10) do
            loop do
              message, _ = @udp_socket.recvfrom 1500
              messages << message.split("\r\n")
            end
          end
        rescue Timeout::Error => e
          puts "Finished waiting #{timeout} seconds"
        end

        root_devices = []
        messages.each do |message|
          root_device = UPnPRootDevice.new(message)
          message.each do |piece|
            puts piece
          end
          puts
          root_devices << root_device
        end

        root_devices
      end

      def ssdp_discover_message
        [
          'M-SEARCH * HTTP/1.1',
          "HOST:#{multicast_host}:#{multicast_port}",
          'ST:upnp:rootdevice',
          'MX:2',
          'MAN:"ssdp:discover"',
          '',
          ''
        ].join("\r\n")
      end
    end

    class UPnPRootDevice
      def initialize(message)
        puts message.pop
      end
    end

  end
end
