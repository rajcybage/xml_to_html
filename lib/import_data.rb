require 'nokogiri'
require_relative './markup.rb'
require_relative './destination.rb'

class ImportData
  attr_reader :tax, :dest

  def initialize(tax_path, dest_path)
    f = File.open(tax_path)
    @tax = Nokogiri::XML(f)
    f2 = File.open(dest_path)
    @dest = Nokogiri::XML(f2)
  end

  # get all ids
  def all_ids
    childs = tax.xpath('//*').children
    childs.map { |x| x.xpath('@atlas_node_id').text }.reject(&:empty?)
  end

  # create the html ouput by passing tax and destination xml
  def create_html
    d = Destination.new('00000', tax, dest)
    build_html_of_op(d)
    all_ids.each do |id|
      destinat = Destination.new(id, tax, dest)
      build_html_of_op(destinat)
    end
  end

  private

  def build_html_of_op(destination)
    local_filename = 'output_files/' + destination.id + '.html'
    doc = Markup.new(destination).build_html
    File.open(local_filename, 'w') { |f| f.write(doc) }
  end
end
