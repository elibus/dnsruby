#--
#Copyright 2007 Nominet UK
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License. 
#You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0 
#
#Unless required by applicable law or agreed to in writing, software 
#distributed under the License is distributed on an "AS IS" BASIS, 
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
#See the License for the specific language governing permissions and 
#limitations under the License.
#++
module Dnsruby
  class RR
    #Class to store generic RRs (RFC 3597)
    class Generic < RR # RFC 3597
      #data for the generic resource record
      attr_reader :data
      
      def from_data(data) #:nodoc: all
        @data = data[0]
      end
      
      def rdata_to_string #:nodoc: all
        if (@data!=nil)
          return  "\\# " +  @data.length.to_s +  " " + @data.unpack("H*")[0]
        end
        return "#NO DATA"
      end
      
      def from_string(data) #:nodoc: all
        @data = data
      end
      
      def encode_rdata(msg, canonical=false) #:nodoc: all
        msg.put_bytes(data)
      end
      
      def self.decode_rdata(msg) #:nodoc: all
        return self.new(msg.get_bytes)
      end
      
      def self.create(type_value, class_value) #:nodoc:
        c = Class.new(Generic)
        #          c.type = type_value
        #          c.klass = class_value
        c.const_set(:TypeValue, type_value)
        c.const_set(:ClassValue, class_value)
        Generic.const_set("Type#{type_value}_Class#{class_value}", c)
        ClassHash[[type_value, class_value]] = c
        return c
      end
    end
    
    #--
    # Standard (class generic) RRs
    #++
    #NS RR
    #Nameserver resource record
    class NS < DomainName
      ClassValue = nil #:nodoc: all
      TypeValue = Types::NS #:nodoc: all
      
      alias nsdname domainname
      alias nsdname= domainname=
    end
    
    #CNAME RR
    #The canonical name for an alias
    class CNAME < DomainName
      ClassValue = nil #:nodoc: all
      TypeValue = Types::CNAME #:nodoc: all

      alias cname domainname
      alias cname= domainname=
    end
    
    #DNAME RR
    class DNAME < DomainName
      ClassValue = nil #:nodoc: all
      TypeValue = Types::DNAME #:nodoc: all
      
      alias dname domainname
      alias dname= domainname=
    end
    
    #MB RR
    class MB < DomainName
      ClassValue = nil #:nodoc: all
      TypeValue = Types::MB #:nodoc: all
      alias madname domainname
      alias madname= domainname=
    end
    
    #MG RR
    class MG < DomainName
      ClassValue = nil #:nodoc: all
      TypeValue = Types::MG #:nodoc: all
      alias mgmname domainname
      alias mgmname= domainname=
    end
    
    #MR RR
    class MR < DomainName
      ClassValue = nil #:nodoc: all
      TypeValue = Types::MR #:nodoc: all
      alias newname domainname
      alias newname= domainname=
    end
    
    #PTR RR
    class PTR < DomainName
      ClassValue = nil #:nodoc: all
      TypeValue = Types::PTR #:nodoc: all
    end
    
    #ANY RR
    # A Query type requesting any RR
    class ANY < RR
      ClassValue = nil #:nodoc: all
      TypeValue = Types::ANY #:nodoc: all
    end
  end  
end
require 'Dnsruby/resource/HINFO'
require 'Dnsruby/resource/MINFO'
require 'Dnsruby/resource/ISDN'
require 'Dnsruby/resource/MX'
require 'Dnsruby/resource/NAPTR'
require 'Dnsruby/resource/NSAP'
require 'Dnsruby/resource/PX'
require 'Dnsruby/resource/RP'
require 'Dnsruby/resource/RT'
require 'Dnsruby/resource/SOA'
require 'Dnsruby/resource/TXT'
require 'Dnsruby/resource/X25'
require 'Dnsruby/resource/SPF'
require 'Dnsruby/resource/CERT'
require 'Dnsruby/resource/LOC'
require 'Dnsruby/resource/OPT'
require 'Dnsruby/resource/TSIG'
require 'Dnsruby/resource/TKEY'
require 'Dnsruby/resource/DNSKEY'
require 'Dnsruby/resource/RRSIG'
require 'Dnsruby/resource/NSEC'
require 'Dnsruby/resource/DS'
require 'Dnsruby/resource/NSEC3'
require 'Dnsruby/resource/NSEC3PARAM'
require 'Dnsruby/resource/DLV'
require 'Dnsruby/resource/SSHFP'
require 'Dnsruby/resource/IPSECKEY'
require 'Dnsruby/resource/HIP'