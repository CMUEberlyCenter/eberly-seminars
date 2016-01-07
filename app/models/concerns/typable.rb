# Typables are simple entities with a key (simple phrase) and are
# accompanied by a label (human reasable display text)
module Typable
  extend ActiveSupport::Concern

  module ClassMethods

    # Retrieve based on the key if param is not a number
    def find( param )
      param.to_i == 0 ? find_by_key( param ) : super
    end

  end

end
