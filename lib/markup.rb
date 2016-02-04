class Markup
  attr_reader :destination

  def initialize(destination)
    @destination = destination
  end

  # static html output file
  def build_html
    html = <<EOF
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv='content-type' content='text/html; charset=UTF-8'>
    <title>Lonely Planet</title>
    <link href='static/all.css' media='screen' rel='stylesheet' type='text/css'>
  </head>

  <body>
    <div id='container'>
      <div id='header'>
        <div id='logo'></div>
        <h1>Lonely Planet: #{destination.the_name}</h1>
      </div>

      <div id='wrapper'>
        <div id='sidebar'>
          <div class='block'>
            <h3>Navigation</h3>
            <div class='content'>
              <div class='inner'>
               <p>
                #{html_format(destination.the_top_hashs, ' >> ')}
                #{!destination.the_top_hashs.empty? ? ">>" : ''}
                #{destination.the_name}
                </p>
                <p>
                #{html_format(destination.the_below_hashs, ' ')}
                </p>
              </div>
            </div>
          </div>
        </div>

        <div id='main'>
          <div class='block'>
            <div class='secondary-navigation'>
              <ul>
                <li class='first'><a href='#'>#{destination.the_name}</a></li>
              </ul>
              <div class='clear'></div>
            </div>
            <div class='content'>
              <div class='inner'>
          		  Introduction
          		  <p>
            		#{destination.intro}
            	  </p>
            		History Overview
                <p>
                  #{destination.history_overview}
          		  </p>
                <p>
                 #{destination.history}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
EOF
    html
  end

  private

  def html_format(arr, str)
    arr.map { |a| '<a href=' + a['id'] + '.html >' + a['name'] + '</a><br>' }.join(str)
  end
end
