module EmojiFlag
  OFFSET          = 127397
  COUNTRY_CODE_RE = /^[A-Z]{2}$/

  def self.new(code : String) : String
    if COUNTRY_CODE_RE.match(code)
      code.codepoints.map(&.+ OFFSET).join(&.chr)
    else
      ""
    end
  end
end
