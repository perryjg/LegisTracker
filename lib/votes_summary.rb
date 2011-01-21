require 'rubygems'
require 'nokogiri'
require 'open-uri'
require_relative 'votes_summary/vote_detail.rb'

class VotesSummary
  attr_reader :xml_string, :url, :house, :vote_details, :response_code

  def initialize( house )
    @house = house
    url = { :house  => 'http://www1.legis.ga.gov/legis/2011_12/list/HouseVotes.xml',
            :senate => 'http://www1.legis.ga.gov/legis/2011_12/list/SenateVotes.xml' }
    xp = { :house => 'votes/vote', :senate => 'voting/vote' }
    @url = url[@house.to_sym]
    @xml_string = fetch( @url )

    doc = Nokogiri::XML( @xml_string )
    vote_nodes = doc.xpath( xp[@house.to_sym] ) 
    @vote_details = vote_nodes.map { |node| VoteDetail.new( node ) }
  end

  def response_success?
    return @response_code == '200' ? true : false
  end

  private

  def fetch( url )
    curl = Curl::Easy.new( url )

    response = ''
    curl.on_success do |c|
      response = c.body_str
    end

    curl.on_failure do |c, err|
      response = c.response_code
    end

    curl.http_get
    @response_code = curl.response_code.to_s
    return response
  end
end
