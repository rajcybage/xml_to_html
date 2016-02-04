require './lib/markup.rb'

describe Markup do
  before do
    f = File.open('input_files/taxonomy.xml')
    tax = Nokogiri::XML(f)
    f2 = File.open('input_files/destinations.xml')
    dest = Nokogiri::XML(f2)
    destin = Destination.new('355611', tax, dest)
    @markup = Markup.new(destin)
  end

  describe 'build_html' do
    it 'should build a html file' do
      expect(@markup.build_html).to include('<html>')
    end

    it 'should contain the text of element' do
      expect(@markup.build_html).to include('Travel Alert: Crime is a problem throughout South Africa;')
    end
  end
end
