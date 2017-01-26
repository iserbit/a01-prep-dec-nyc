require 'rspec'
require 'spec_helper'
require 'strings'

describe "Strings" do
  describe "titleize" do
    it "capitalizes a word" do
      expect(titleize("jaws")).to eq("Jaws")
    end

    it "capitalizes every word (aka title case)" do
      expect(titleize("david copperfield")).to eq("David Copperfield")
    end

    it "doesn't capitalize 'little words' in a title" do
      expect(titleize("war and peace")).to eq("War and Peace")
    end

    it "does capitalize 'little words' at the start of a title" do
      expect(titleize("the bridge over the river kwai")).to eq("The Bridge over the River Kwai")
    end
  end

  describe "#translate" do
    it "translates a word beginning with a vowel" do
      s = translate("apple")
      expect(s).to eq("appleay")
    end

    it "translates a word beginning with a consonant" do
      s = translate("banana")
      expect(s).to eq("ananabay")
    end

    it "translates a word beginning with two consonants" do
      s = translate("cherry")
      expect(s).to eq("errychay")
    end

    it "translates two words" do
      s = translate("eat pie")
      expect(s).to eq("eatay iepay")
    end

    it "translates a word beginning with three consonants" do
      expect(translate("three")).to eq("eethray")
    end

    it "counts 'sch' as a single phoneme" do
      s = translate("school")
      expect(s).to eq("oolschay")
    end

    it "counts 'qu' as a single phoneme" do
      s = translate("quiet")
      expect(s).to eq("ietquay")
    end

    it "counts 'qu' as a consonant even when it's preceded by a consonant" do
      s = translate("square")
      expect(s).to eq("aresquay")
    end

    it "translates many words" do
      s = translate("the quick brown fox")
      expect(s).to eq("ethay ickquay ownbray oxfay")
    end
  end

  describe "#caesar_cipher" do
    it "encodes a simple word" do
      expect(caesar_cipher("aaa", 11)).to eq("lll")
    end

    it "wraps around the alphabet" do
      expect(caesar_cipher("zzz", 1)).to eq("aaa")
    end

    it "encodes multiple words" do
      expect(caesar_cipher("catz hatz", 2)).to eq("ecvb jcvb")
    end
  end

  describe "#jumble_sort" do
    it "defaults to alphabetical order" do
      expect(jumble_sort("hello")).to eq("ehllo")
    end

    it "takes an alphabet array and sorts by that order" do
      alph = ("a".."z").to_a
      hello = "hello".chars.uniq
      alph -= hello
      alphabet = (hello += alph)

      expect(jumble_sort("hello", alphabet)).to eq("hello")
    end

    it "sorts by a reversed alphabet" do
      reverse = ("a".."z").to_a.reverse
      expect(jumble_sort("hello", reverse)).to eq("ollhe")
    end
  end

  describe "real_words_in_string" do
    it "finds a simple word" do
      words = "asdfcatqwer".real_words_in_string(["cat", "car"])
      expect(words).to eq(["cat"])
    end

    it "doesn't find words not in the dictionary" do
      words = "batcabtarbrat".real_words_in_string(["cat", "car"])
      expect(words).to be_empty
    end

    it "finds words within words" do
      dictionary = ["bears", "ear", "a", "army"]
      words = "erbearsweatmyajs".real_words_in_string(dictionary)
      expect(words).to eq(["bears", "ear", "a"])
    end
  end

  describe "#symmetric_substrings" do
    it "handles a simple example" do
      expect("aba".symmetric_substrings).to match_array(["aba"])
    end

    it "handles two substrings" do
      expect("aba1cdc".symmetric_substrings).to match_array(["aba", "cdc"])
    end

    it "handles nested substrings" do
      expect("xabax".symmetric_substrings).to match_array(["aba", "xabax"])
    end
  end
end
