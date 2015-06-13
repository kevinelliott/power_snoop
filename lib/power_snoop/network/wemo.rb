module PowerSnoop
  module Network

    class Wemo
      attr_reader :bind_host, :bind_port, :multicast_host, :multicast_port, :timeout

      def initialize(options = {})
        @bind_host = options[:host] || discover_ip
        @bind_port = options[:port] || 54321
        @multicast_host = '239.255.255.250'
        @multicast_port = 1900
        @timeout = options[:timeout] || 3

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
          puts "Found device '#{link.device[:friendly_name]}' at #{link.host}:#{link.port}"
          links << link
        end
        links.first
      end

      def scan_for_devices
        link = discover_wemo_link
        link.scan_for_devices
        link.to_wemo_link
      end
    end

    class WemoLinkRootDevice
      attr_accessor :location, :usn, :server, :st
      attr_accessor :device, :service_list

      def initialize(upnp_root_device)
        require 'uri'
        @location = URI.parse upnp_root_device.headers['LOCATION']
        @usn      = upnp_root_device.headers['USN']
        @server   = upnp_root_device.headers['SERVER']
        @st       = upnp_root_device.headers['ST']

        get_location
      end

      def host
        location.host
      end

      def port
        location.port
      end

      def get_location
        require 'net/http'
        require 'nori'
        content = Net::HTTP.get(location)
        result  = Nori.new(convert_tags_to: lambda { |tag| tag.snakecase.to_sym }).parse(content)[:root]

        self.device = result[:device]
      end

      def scan_for_devices

      end

      def to_wemo_link
        link = PowerSnoop::Devices::Wemo::Link.new
        link.firmware_version = device[:firmware_version]
        link.friendly_name    = device[:friendly_name]
        link.mac_address      = device[:mac_address]
        link.manufacturer     = device[:manufacturer]
        link.model            = {
          description: device[:model_description],
          name: device[:model_name],
          number: device[:model_number],
          url: device[:model_url]
        }
        link.serial_number    = device[:serial_number]
        link.state            = device[:binary_state]
        link.upc              = device[:upc]
        link
      end
    end

  end
end
