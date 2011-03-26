#require 'nokogiri'

class BillStatus
  attr_reader :node
  
  def initialize( node )
    @node = node
  end
  
  def attributes
    return @node.attributes()
  end
  
  def Type
    return @node.xpath( 'Number' ).inner_text.match( /^([HS][BR])/ ).captures[0]
  end
  
  def Num
    return @node.xpath( 'Number' ).inner_text.match( /(\d+)$/ ).captures[0]
  end
  
  def StatusDate
    m, d, y = @node.attribute( 'StatusDate' ).to_s.split( /\// ).map { |num| num.to_i }
    return "20%02d-%02d-%02d" % [ y, m, d ]
  end
  
  def EffDate
    if @node.xpath( 'EffDate/text()' ).inner_text.empty?
      return nil
    else
      return Date.strptime( @node.xpath( 'EffDate' ).inner_text, '%m/%d/%y' ).to_s
    end
  end
  
  def HCommittee_full
    hcom_hash = Hash.new
    hcom = @node.xpath( 'HCommittee' ).first
    
    return { 'Id' => '', 'LongName' => '', 'ShortName' => '' } if hcom.nil?
    
    hcom.attributes.keys.each do |key|
      hcom_hash[ "#{key}" ] = hcom.attribute( "#{key}" ).to_s
    end
    hcom_hash['ShortName'] = hcom.inner_text
    
    return hcom_hash
  end
  
  def HCommittee
    com = self.HCommittee_full
    return com['Id']
  end
  
  def SCommittee
    com = self.SCommittee_full
    return com['Id']
  end
  
  def SCommittee_full
    scom_hash = Hash.new
    scom = @node.xpath( 'SCommittee' ).first
    
    return { 'Id' => '', 'LongName' => '', 'ShortName' => '' } if scom.nil?
    
    scom.attributes.keys.each do |key|
      scom_hash[ "#{key}" ] = scom.attribute( "#{key}" ).to_s
    end
    scom_hash['ShortName'] = scom.inner_text
    
    return scom_hash
  end
  
  def Sponsors
    sponsors = Array.new
    
    @node.xpath( 'Sponsor' ).each do |sponsor|
      sponsor_hash = Hash.new
      
      sponsor.attributes.keys.each do |key|
        sponsor_hash[ "#{key}" ] = sponsor.attribute( "#{key}" ).to_s
      end
      sponsor_hash['Text'] = sponsor.inner_text
      sponsors.push( sponsor_hash )
    end
    
    return sponsors
  end
  
  def StatusHistory
    stats = Array.new
    @node.xpath( 'StatusHistory' ).children.each do |status|
      status_hash = Hash.new
      status.attributes.keys.each do |key|
        status_hash[ "#{key}" ] = status.attribute( "#{key}" ).to_s
      end
      status_hash['StatusDate'].gsub!( /T/, ' ' )
      status_hash['AmSubDesc'] = '' unless status_hash.has_key?( 'AmSubDesc' )
      status_hash['description'] = status.inner_text
      stats.push( status_hash )
    end
    return stats
  end
  
  def Versions
    versions = Array.new
    @node.xpath( 'Versions' ).children.each do |version|
      version_hash = Hash.new
      version.attributes.keys.each do |key|
        version_hash[ "#{key}" ] = version.attribute( "#{key}" ).to_s
      end
      
      version_hash[ 'Description' ] = version.xpath( 'Description' ).inner_text
      version_hash[ 'FileID' ] = version.xpath( 'FileID' ).inner_text
      versions.push( version_hash )
    end
    return versions
  end
  
  def Citation
    if self.Title.match( /Code Section (\d{1,2})-(\d{1,2})-\d{1,2}/ )
      return { 'codeTitle' => $1, 'codeChapter' => $2 }
    elsif self.Title.match( /Chapter (\d{1,2}) of Title (\d{1,2})/ )
      return { 'codeTitle' => $2, 'codeChapter' => $1 }
    elsif self.Title.match(  /to ammend Title (\d{1,2})/ )
      return { 'codeTitle' => $1, 'codeChapter' => nil }
    elsif self.Title.match(  /Title (\d{1,2})/ )
      return { 'codeTitle' => $1, 'codeChapter' => nil }
    else
      return { 'codeTitle' => nil, 'codeChapter' => nil }
    end
  end
  
  def Carryover
    if @node.has_attribute?( "Carryover" )
      return @node.attribute( "Carryover" ).to_s
    else
      return "0"
    end
  end
  
  def method_missing( name )
    if @node.has_attribute?( "#{name}" )
      return @node.attribute( "#{name}" ).to_s
    elsif not @node.xpath( "#{name}" ).empty?
      text = @node.xpath( "#{name}/text()" ).inner_text
      text.gsub!( /"/, "'" )
      return text
    else
      #super.method_missing( name )
      return ''
    end
  end
  
  def bill_data_array
    fields = %w[ Id Type Num Suffix Carryover YearID StatusDate Number Short_Title CompositeCaption Title HCommittee SCommittee EffDate BStatus Footnote ]
    data = Array.new
    fields.each do |field|
      data.push( self.send( field.to_sym ) )
    end
    
    cite = self.Citation
    data.push( cite['codeTitle'] )
    data.push( cite['codeChapter'] )
    
    return data
  end
  
  def sponsor_data_array
    fields = %w[ bill_id Seq Type Id ]
    return self.data_matrix( self.Sponsors, fields )
  end
  
  def status_data_array
    fields = %w[ bill_id StatusDate StatusCode AmSubDec ]
    return self.data_matrix( self.StatusHistory, fields )
  end
  
  def version_data_array
    fields = %w[ bill_id Number Id Description FileID ]
    return self.data_matrix( self.Versions, fields )
  end
  
  def data_matrix( data_rows, fields )
    data = Array.new
    data_rows.each do |row|
      row['bill_id'] = self.Id if fields.include?( 'bill_id' )
      data.push( fields.map { |field| row[field] } )
    end
    return data
  end
  
  def to_s
    return @node.to_s
  end
  
  def to_xml
    return @node.to_xml
  end
  
end
