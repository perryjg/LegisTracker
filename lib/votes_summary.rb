require 'rubygems'
require 'nokogiri'
require 'open-uri'
require_relative 'votes_summary/vote_detail.rb'

class VotesSummary
  attr_reader :xml_string, :url, :house, :votes

  def initialize( house )
    @house = house
    url = { :house  => 'http://www1.legis.ga.gov/legis/2011_12/list/HouseVotes.xml',
            :senate => 'http://www1.legis.ga.gov/legis/2011_12/list/SenateVotes.xml' }
    xp = { :house => 'votes/vote', :senate => 'voting/vote' }
    @url = url[@house.to_sym]
    @xml_string = fetch( @url )

    doc = Nokogiri::XML( @xml_string )
    vote_nodes = doc.xpath( xp[@house.to_sym] ) 
    @votes = vote_nodes.map { |node| VoteDetail.new( node ) }
  end

  def fetch( url )
    xml_string = open( url ).read
    return xml_string
  end
end
