require 'optparse'

module ArgsParser
  def self.parse(args, version)
    options = {}

    opts_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: main.rb [options]'

      opts.on('-u', '--update', 'Flag to update films data') do
        puts 'Updating films database in progress'
        options[:update] = true
      end

      opts.on('-h', '--help', 'Show help') do
        puts opts
        exit
      end

      opts.on('-v', '--version', 'Show version') do
        puts "v. #{version}"
        exit
      end
    end

    begin
      opts_parser.parse!(args)
    rescue OptionParser::InvalidOption
      puts 'Unknown option. Use the options below.'
      opts_parser.parse!(['-h'])
    end

    options
  end
end
