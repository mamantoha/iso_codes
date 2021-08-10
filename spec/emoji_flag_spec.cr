describe EmojiFlag do
  it "should find emoji flag" do
    EmojiFlag.new("TW").should eq("🇹🇼")
  end
end
