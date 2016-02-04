require './lib/import_data.rb'

describe ImportData do
  describe 'get_lower_ids' do
    subject(:import) { ImportData.new('input_files/taxonomy.xml', 'input_files/destinations.xml') }

    it 'gets a all ids lower in taxonomy' do
      expect(import.all_ids.join(', ')).to eq('355064, 555064, 355611, 355629, 355633, 355612, 355614, 355616, 355619, 355622, 355624, 355626, 355613, 355615, 355617, 355618, 355620, 355621, 355623, 355625, 355627, 355628, 355630, 355632, 355631, 555611')
    end
  end
end

