require './lib/destination.rb'

describe Destination do
  before do
    f = File.open('input_files/taxonomy.xml')
    tax = Nokogiri::XML(f)
    f2 = File.open('input_files/destinations.xml')
    dest = Nokogiri::XML(f2)
    @dest = Destination.new('355611', tax, dest)
  end

  describe 'initialization' do
    it 'sets a location' do
      expect(@dest.the_name).to eq('South Africa')
    end
  end

  describe 'the_name' do
    it 'gets a name' do
      expect(@dest.the_name).to eq('South Africa')
    end
  end

  describe 'get_below_hashs' do
    it 'gets a hash below in taxonomy' do
      expect(@dest.the_below_hashs.map { |x| x['id'] }.join(', ')).to eq('355612, 355614, 355616, 355619, 355622, 355624, 355626')
    end
  end

  describe 'get_top_hashs' do
    it 'gets a hash of higher in taxonomy' do
      expect(@dest.the_top_hashs.map { |x| x['name'] }.join(', ')).to eq('World, Africa')
    end
  end

  describe 'get_intro' do
    it 'gets the introductory content from destinations' do
      text = 'Travel Alert: Crime is a problem throughout South Africa'
      expect(@dest.intro.to_s[0..text.length - 1]).to eq(text)
    end
  end

  describe 'get_history' do
    it 'gets the history content from destinations' do
      text = 'In 1910 the Union of South Africa was created'
      expect(@dest.history.to_s[0..text.length - 1]).to eq(text)
    end
  end

  describe 'get_history_overview' do
    it 'gets the history overview content from destinations' do
      text = 'The earliest recorded inhabitants of this area of Africa were'
      expect(@dest.history_overview.to_s[0..text.length - 1]).to eq(text)
    end
  end
end
