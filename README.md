# PowerSnoop

<img src="http://www.oldschool993.com/wp-content/uploads/2015/04/Snoop-Dogg-1.jpg">

Scan, monitor, and calculate power consumption for common devices on and off a network. Support for generic devices will also be included.

Features:
* define and calculate power consumption for a variety of common and specialty electronic devices
* scan network for known device types
* monitor and report power consumption over time
* export reports to data formats and PDFs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'power_snoop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install power_snoop

## Usage

```ruby
require 'power_snoop'
```

### Get consumption for a WeMo Smart LED Bulb when it is turned off

```ruby
PowerSnoop::Devices::Wemo::SmartLEDBulb.consumption_when_off
```

```ruby
#<Unitwise::Measurement value=0.5 unit=watt>
```

### Get maximum consumption for the WeMo Smart LED Bulb

```ruby
PowerSnoop::Devices::Wemo::SmartLEDBulb.consumption_when_max
```

```ruby
#<Unitwise::Measurement value=10 unit=watt>
```

### Get power for the WeMo Smart LED Bulb when at dim level 200 (78%)

```ruby
PowerSnoop::Devices::Wemo::SmartLEDBulb.consumption_when_at_dim(200)
```

```ruby
#<Unitwise::Measurement value=7.91 unit=watt>
```

### Scan for WeMo devices on the network

```ruby
wemo = PowerSnoop::Network::Wemo.new
link = wemo.scan_for_devices
link
```

```
Binding to 10.0.0.61:54321
Discovering devices
Sent multicast datagram to 239.255.255.250:1900
Finished waiting 5 seconds
Found device 'WeMo Link' at 10.0.0.29:49154
```

### Generic scan for devices on the network using UPnP

```ruby
upnp = PowerSnoop::Network::UPnP.new
upnp.ssdp_discover
```

```ruby
 => [#<PowerSnoop::Network::UPnPRootDevice:0x007fac629b7a38 @protocol="HTTP/1.1 200 OK", @headers={"Cache-Control"=>"max-age=3600", "ST"=>"upnp:rootdevice", "USN"=>"uuid:824ff22b-8c7d-41c5-a131-44f534e125551::upnp:rootdevice", "EXT:"=>nil, "Server"=>"Arris/1.0 UPnP/1.0 miniupnpd/1.0", "Location"=>"http://10.0.0.1:5000/rootDesc.xml"}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac629b65e8 @protocol="HTTP/1.1 200 OK", @headers={"CACHE-CONTROL"=>"max-age=86400", "DATE"=>"Sat, 13 Jun 2015 08:01:06 GMT", "EXT:"=>nil, "LOCATION"=>"http://10.0.0.29:49154/setup.xml", "OPT"=>"\"http://schemas.upnp.org/upnp/1/0/\"; ns=01", "01-NLS"=>"97303dd0-1dd1-11b2-bf8b-ebcd1f3911f0", "SERVER"=>"Unspecified, UPnP/1.0, Unspecified", "X-User-Agent"=>"redsonic", "ST"=>"upnp:rootdevice", "USN"=>"uuid:Bridge-1_0-231447B010024F::upnp:rootdevice"}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac629b4d38 @protocol="HTTP/1.1 200 OK", @headers={"CACHE-CONTROL"=>"max-age = 1800", "EXT:"=>nil, "LOCATION"=>"http://10.0.0.23:1400/xml/device_description.xml", "SERVER"=>"Linux UPnP/1.0 Sonos/29.4-90021 (ZPS3)", "ST"=>"upnp:rootdevice", "USN"=>"uuid:RINCON_B8E93739D48A01400::upnp:rootdevice", "X-RINCON-HOUSEHOLD"=>"Sonos_hnBTlpIiWoW0bdq8DvQbngazWc", "X-RINCON-BOOTSEQ"=>"5030", "X-RINCON-PROXY"=>"RINCON_000E58B80FF801400"}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac6299abb8 @protocol="HTTP/1.1 200 OK", @headers={"CACHE-CONTROL"=>"max-age = 1800", "EXT:"=>nil, "LOCATION"=>"http://10.0.0.21:1400/xml/device_description.xml", "SERVER"=>"Linux UPnP/1.0 Sonos/29.4-90021 (ZPS1)", "ST"=>"upnp:rootdevice", "USN"=>"uuid:RINCON_B8E93751CE3801400::upnp:rootdevice", "X-RINCON-HOUSEHOLD"=>"Sonos_hnBTlpIiWoW0bdq8DvQbngazWc", "X-RINCON-BOOTSEQ"=>"57"}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac6298bcd0 @protocol="HTTP/1.1 200 OK", @headers={"CACHE-CONTROL"=>"max-age = 1800", "EXT:"=>nil, "LOCATION"=>"http://10.0.0.22:1400/xml/device_description.xml", "SERVER"=>"Linux UPnP/1.0 Sonos/29.4-90021 (ZPS1)", "ST"=>"upnp:rootdevice", "USN"=>"uuid:RINCON_B8E9375243EA01400::upnp:rootdevice", "X-RINCON-HOUSEHOLD"=>"Sonos_hnBTlpIiWoW0bdq8DvQbngazWc", "X-RINCON-BOOTSEQ"=>"43"}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac629886c0 @protocol="HTTP/1.1 200 OK", @headers={"CACHE-CONTROL"=>"max-age = 1800", "EXT:"=>nil, "LOCATION"=>"http://10.0.0.19:1400/xml/device_description.xml", "SERVER"=>"Linux UPnP/1.0 Sonos/29.4-90021 (ZPS3)", "ST"=>"upnp:rootdevice", "USN"=>"uuid:RINCON_B8E93739D49E01400::upnp:rootdevice", "X-RINCON-HOUSEHOLD"=>"Sonos_hnBTlpIiWoW0bdq8DvQbngazWc", "X-RINCON-BOOTSEQ"=>"5156", "X-RINCON-PROXY"=>"RINCON_000E58B80FF801400"}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac629782e8 @protocol="HTTP/1.1 200 OK", @headers={"CACHE-CONTROL"=>"max-age = 1800", "EXT:"=>nil, "LOCATION"=>"http://10.0.0.13:1400/xml/device_description.xml", "SERVER"=>"Linux UPnP/1.0 Sonos/29.4-90021 (ZPS9)", "ST"=>"upnp:rootdevice", "USN"=>"uuid:RINCON_000E58B80FF801400::upnp:rootdevice", "X-RINCON-HOUSEHOLD"=>"Sonos_hnBTlpIiWoW0bdq8DvQbngazWc", "X-RINCON-BOOTSEQ"=>"44"}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac62969f18 @protocol="HTTP/1.1 200 OK", @headers={"CACHE-CONTROL"=>"max-age = 1800", "EXT:"=>nil, "LOCATION"=>"http://10.0.0.20:1400/xml/device_description.xml", "SERVER"=>"Linux UPnP/1.0 Sonos/29.4-90021 (ZPS1)", "ST"=>"upnp:rootdevice", "USN"=>"uuid:RINCON_B8E93751CDA601400::upnp:rootdevice", "X-RINCON-HOUSEHOLD"=>"Sonos_hnBTlpIiWoW0bdq8DvQbngazWc", "X-RINCON-BOOTSEQ"=>"73"}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac63007690 @protocol="HTTP/1.1 200 OK", @headers={"ST"=>"upnp:rootdevice", "USN"=>"uuid:aca7befe-fba0-4564-842b-05abda43ac97::upnp:rootdevice", "Location"=>"http://10.0.0.16:2869/upnphost/udhisapi.dll?content=uuid:aca7befe-fba0-4564-842b-05abda43ac97", "OPT:\"http://schemas.upnp.org/upnp/1/0/\"; ns=01"=>nil, "01-NLS"=>"5cdfd8fb775616fb24a010021fea042d", "Cache-Control"=>"max-age=1800", "Server"=>"Microsoft-Windows/6.2 UPnP/1.0 UPnP-Device-Host/1.0", "Ext"=>nil}>, #<PowerSnoop::Network::UPnPRootDevice:0x007fac63006f60 @protocol="HTTP/1.1 200 OK", @headers={"ST"=>"upnp:rootdevice", "USN"=>"uuid:ca3b1b50-195b-4e1b-95f6-6b3ab4e85b32::upnp:rootdevice", "Location"=>"http://10.0.0.16:2869/upnphost/udhisapi.dll?content=uuid:ca3b1b50-195b-4e1b-95f6-6b3ab4e85b32", "OPT:\"http://schemas.upnp.org/upnp/1/0/\"; ns=01"=>nil, "01-NLS"=>"5cdfd8fb775616fb24a010021fea042d", "Cache-Control"=>"max-age=1800", "Server"=>"Microsoft-Windows/6.2 UPnP/1.0 UPnP-Device-Host/1.0", "Ext"=>nil}>]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/power_snoop/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
