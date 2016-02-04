require 'nokogiri'

class Destination
  attr_reader :id, :tax, :dest

  # initialize with xml content of taxonomy and destination file
  def initialize(id, tax, destin)
    @id = id
    @tax = tax
    @dest = destin
  end

  # get the name of the location
  def the_name
    return 'World' if id == '00000'
    node = tax.xpath("//*/node[@atlas_node_id = '#{id}']/node_name")
    node.text.strip
  end

  # get the hash of ids with name of below nodes
  def the_below_hashs
    path = "//*/node[@atlas_node_id = '#{id}']"
    if id == '00000'
      path = "//*[count(ancestor::node())=2]"
    end
    xmlc = tax.xpath(path).children
    reform(xmlc).map{ |x| {'id' => x.xpath("@atlas_node_id").text.to_s, 'name' => x.text.split("\n")[1].to_s} }
  end
  
  # get the hash of ids with name of above nodes
  def the_top_hashs
    h_ar = []
    xmlc = tax.xpath("//*/node[@atlas_node_id = '#{id}']/..")
    while !xmlc.nil? && !xmlc.inner_text.split("\n")[1].nil?
      id_text = xmlc.xpath("@atlas_node_id").text.strip
      name_text = xmlc.inner_text.split("\n")[1].strip
      if !name_text.empty? and !id_text.empty?
        h_ar << { 'id' => id_text, 'name' => name_text }
      end
      xmlc = xmlc.xpath('..')
    end
    aworld(h_ar)
    h_ar.reverse
  end

  # get the introduction from node
  def intro
    xml_request = dest.xpath("//destinations/destination[@atlas_id='#{id}']/introductory/introduction/overview")
    xml_request.text.strip
  end

  # get the history from node
  def history
    xml_request = dest.xpath("//destinations/destination[@atlas_id='#{id}']/history/history/history")
    xml_request.text.strip
  end

  # get the overview history from node
  def history_overview
    xml_request = dest.xpath("//destinations/destination[@atlas_id='#{id}']/history/history/overview")
    xml_request.text.strip
  end

  private


  def reform(arr)
    arr.reject { |x| x.inner_text.strip.empty? || x.text.strip == the_name }
  end

  def aworld(arr)
    if id != '00000'
      arr << { 'id' => '00000', 'name' => 'World' }
    end
  end
end
