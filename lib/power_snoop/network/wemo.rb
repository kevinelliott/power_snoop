module PowerSnoop
  module Network

    class Wemo
      attr_reader :bind_host, :bind_port, :multicast_host, :multicast_port, :timeout

      def initialize(options = {})
        @bind_host = options[:host] || discover_ip
        @bind_port = options[:port] || 54321
        @multicast_host = '239.255.255.250'
        @multicast_port = 1900
        @timeout = options[:timeout] || 5

        @upnp = PowerSnoop::Network::UPnP.new(host: bind_host, port: bind_port, multicast_host: multicast_host, multicast_port: multicast_port, timeout: timeout)
      end

      def discover_ip
        '10.0.0.61'
      end

      def discover_wemo_link
        root_devices = @upnp.ssdp_discover
        wemo_root_devices = root_devices.select { |device| device.headers.has_key?('X-User-Agent') && device.headers['X-User-Agent'] == 'redsonic' }

        links = []
        wemo_root_devices.each do |device|
          link = WemoLinkRootDevice.new(device)
          puts "Found device WeMo Link at #{link.host}:#{link.port}"
          links << link
        end
        links.first
      end

      def scan_for_devices
        link = discover_wemo_link
        link.retrieve_location
      end
    end

    class WemoLinkRootDevice
      attr_accessor :location, :usn, :server, :st

      def initialize(upnp_root_device)
        require 'uri'
        @location = URI.parse upnp_root_device.headers['LOCATION']
        @usn      = upnp_root_device.headers['USN']
        @server   = upnp_root_device.headers['SERVER']
        @st       = upnp_root_device.headers['ST']
      end

      def host
        location.host
      end

      def port
        location.port
      end

      def retrieve_location
        require 'net/http'
        require 'nori'
        content = Net::HTTP.get(location)
        Nori.new.parse(content)
      end

      def scan_for_devices

      end
    end

  end
end
