class CarnegieMellonPerson < ActiveLdap::Base
  ldap_mapping :dn_attribute => "guid",
               :prefix => "ou=Person",
               :classes => ["cmuPerson"]

  def self.find_by_andrewid( andrewid )
    find("cmuandrewid=#{andrewid}", :attributes => ['cmuandrewid',
                                                    'cn', 
                                                    'mail',
                                                    'sn',
                                                    'cmuDepartment',
                                                    'cmuStudentClass'
                                                   ]) 
  end

  def self.generic_search( term )
    #ActiveLdap::Base.search(:base => 'ou=Person,dc=cmu,dc=edu', :filter => "(cmuandrewid=*#{term}*)",
    #             :scope => :sub,:attributes => ['cmuandrewid', 'cn'])
    find("cmuandrewid=#{andrewid}")
  end
end
