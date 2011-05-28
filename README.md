Install
-------

    # Create config/database.yml
    rake db:setup
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
    gunzip GeoIP.dat.gz
    # Export the CSV from https://spreadsheets.google.com/spreadsheet/ccc?key=0AieNfGC6EPFddGFlY19ubzFxYU9NSHNfcDRiVm1WNlE
    ./script/csvimport.rb

License
-------

Copyright (c) 2011 Efficient Cloud Ltd

Code licensed under MIT license, dataset licensed under CC-BY-NC-SA.