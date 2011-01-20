class VoteDetail
  attr_reader :node, :members

  def initialize( node )
    @node = node
    @totals = @node.children[0]
    member_nodes = @node.children.reject {|c| c.name != 'member' }
    
    @members = []
    member_nodes.each do |m|
      attr = Hash.new
      m.attributes.values.each do |a|
        attr[a.name] = a.value
      end
      @members.push( attr )
    end
  end

  def method_missing( name )
    if @node.has_attribute?( "#{name}" )
      return @node.attribute( "#{name}" ).to_s
    elsif @totals.has_attribute?( "#{name}" )
      return @totals.attribute( "#{name}" ).value.to_i
    else
      super.method_missing( name )
    end
  end
end
