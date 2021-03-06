class ScoreboardSetup < ActiveRecord::Base
  belongs_to :assessment
  trim_field :banner, :colspec
  validate :col_spec

  SERIALIZABLE = Set.new [ :banner, :colspec ]
  def serialize
    Utilities.serializable attributes, SERIALIZABLE
  end

  def self.deserialize s
    new s
  end

protected
  # Validates a JSON column spec for correctness before saving it the database
  def col_spec
    # An empty spec is OK
    return if colspec.blank?

    # The parse will throw an exception if the string has a JSON syntax error
    begin 
      # Quote JSON keys and values if they are not already quoted
      quoted = colspec.gsub(/([a-zA-Z0-9]+):/, '"\1":').gsub(/:([a-zA-Z0-9]+)/, ':"\1"')
      parsed = ActiveSupport::JSON.decode(quoted)
    rescue Exception => e
      errors.add "colspec", "#{e}"
      return
    end

    # Colspecs must include a scoreboard array object
    unless parsed["scoreboard"]
      errors.add "colspec", "missing 'scoreboard' array object"
      return
    end

    # Scoreboard object must be an array of hashes. The only valid keys are 'hdr' and 'asc'.
    unless parsed["scoreboard"][0]
      errors.add "colspec", "the 'scoreboard' object must be a non-empty array of hashes"
      return
    end

    parsed["scoreboard"].each_with_index do |hash, i|
      unless hash.is_a? Hash
        errors.add "colspec", "scoreboard[#{i}] is not a hash object"
        return
      end

      unless hash["hdr"]
        errors.add "colspec", "scoreboard[#{i}] hash is missing a 'hdr' object"
        return
      end

      hash.each_key do |k| 
        unless k == "hdr" or k == "asc"
          errors.add "colspec", "unknown key('#{k}') in scoreboard[#{i}]"
          return
        end

        if k == "asc" and i > 2
          errors.add "colspec", "'asc' key in col #{i} ignored because only the first three columns are sorted."
        end
      end
    end
  end
end
