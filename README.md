## Lonely Planet 

## Getting Started

1. Install dependencies (nokogiri, turnip and rspec):

        bundle install

2. At the command prompt run the application with the two xml files as arguments

        ruby example.rb input_files/taxonomy.xml input_files/destinations.xml

 You can provide as your own xml files.

3. To view the created batch of html files:

        open output_files/00000.html

4. For test.
  
         bundle exec rspec spec

   to view the root ("World") page of processed batch. The batch files are saved to the output_files directory in the format atlas_id.html where atlas_id is the id of the destination in both the taxonomy and destinations files.
