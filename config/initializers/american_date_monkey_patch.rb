#
# &copy; 2009 Andrew Coleman
# Released under MIT license.
# http://www.opensource.org/licenses/mit-license.php
#
# total hack to allow american style date parsing.
# does not allow european-ish date parsing, sorry.
#
# some credit from:
# http://talklikeaduck.denhaven2.com/2009/04/26/ruby-1-9-compatibility-for-ri_cal-what-it-took-and-some-side-thoughts
#

if RUBY_VERSION >= '1.9.2'
  class String
    def to_date
      if self.blank?
        nil
      elsif self =~ /(\d{1,2})\/(\d{1,2})\/(\d{4})/
        ::Date.civil($3.to_i, $1.to_i, $2.to_i) rescue nil
      else
        ::Date.new(*::Date._parse(self, false).values_at(:year, :mon, :mday))
      end
    end
  end

  class Date
    def self.parse(str)
      str.to_date
    end
  end
  # active record will call something else on dates on access
  class ActiveRecord::ConnectionAdapters::Column
    def self.fallback_string_to_date(string)
      string.to_date
    end
  end
end

