require 'JSON'
require 'faraday'
require 'pry'

class WeatherForecast
  city = ARGV[0]

  response = (Faraday.get('http://api.openweathermap.org/data/2.5/forecast?q=#{@city},us&units=imperial&APPID=442eba5b3e3a3ae8ead5698479bcdaa8'))
  data = JSON.parse(response.body)
  data["list"].each do |forecast|
    puts "#{forecast["dt_txt"]} -- #{forecast["main"]["temp"]} degrees" 
  end
end 