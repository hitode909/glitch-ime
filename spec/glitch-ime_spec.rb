# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Glitchime" do
  it "can create instance" do
    lambda{ GlitchIME.new }.should raise_error(ArgumentError)
    GlitchIME.new('こんにちは').should be_kind_of GlitchIME
  end

  it "can glitch text" do
    source = 'あけましておめでとうございます，きゅうねんちゅうはおせわになりました，ことしはよろしくおねがいいたします'
    ime = GlitchIME.new(source)
    ime.generate.should be_kind_of String
    ime.generate.should_not equal source
  end

  it "can generate many text" do
    source = 'あけましておめでとうございます，きゅうねんちゅうはおせわになりました，ことしはよろしくおねがいいたします'
    ime = GlitchIME.new(source)
    (1..10).map{ ime.generate }.uniq.should have_at_least(2).items
  end

end
