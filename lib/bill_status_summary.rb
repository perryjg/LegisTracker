#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'date'
require_relative 'bill_status_summary/bill_status'

class BillStatusSummary
  attr_reader :xml_string, :response_code, :bills, :bill_count, :bill_nodes
  
  def initialize( url = 'http://www1.legis.ga.gov/legis/2011_12/list/BillSummary.xml' )
    @url = url
    @xml_string = fetch( @url )
#    @bills = parse( @xml_string )
    doc = Nokogiri::XML( @xml_string )
    @bill_nodes = doc.xpath( '//Bill' )
    @bill_count = @bill_nodes.size
    @bills = @bill_nodes.map { |bill| BillStatus.new( bill ) }
  end

  def response_success?
    if @response_code == '200'
      return true
    else
      return false
    end
  end
  
  private
  
  def parse( xml_string )
    xml = Nokogiri::XML( xml_string )
    bill_nodes = xml.xpath( '//Bills' )
    return bill_nodes.to_a.map { |bill| BillStatus.new( bill ) }
  end
  
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

