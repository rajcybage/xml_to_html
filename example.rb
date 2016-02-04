#!/usr/bin/env ruby
require './lib/import_data.rb'
require './lib/destination.rb'
require './lib/markup.rb'

if !ARGV[1].nil? && !ARGV[0].nil? && File.exist?(ARGV[1]) && File.exist?(ARGV[0])
  batch = ImportData.new(ARGV[0], ARGV[1])
  batch.create_html
  puts 'Execution completed look output_files/00000.html'
else
  puts 'The file is missing'
end
