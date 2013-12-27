module MyAttributes
  def build_children(children, attributes_hash)
   if attributes_hash.is_a? Array
     attributes_hash.each{|attr| self.send(children).build(attr)}
   else
     self.send(children).build(attributes_hash)
   end if self.send(children)
  end
end