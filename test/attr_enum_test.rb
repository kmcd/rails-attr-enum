require 'test_helper'
require 'attr_enum'

SUITS = %w( clubs diamonds hearts spades )

class Card < ActiveRecord::Base
  attr_enum :suit, SUITS
end

class AttrEnumTest < ActiveSupport::TestCase
  load_schema
  
  def setup
    @card = Card.create!
  end
  
  test "should create a class constant" do
    assert_equal SUITS, Card::SUIT_TYPES
  end
  
  test "should have a getter" do
    assert @card.suit.nil?
  end
  
  test "should have a setter" do
    SUITS.each do |suit|
      @card.update_attribute :suit, suit
      assert_equal suit, @card.reload.suit
    end
  end
  
  test "should enforce type contraint" do
    error_msg = assert_raise(TypeError) { @card.update_attribute :suit, 'jacks' }
    assert_match /Must be one of #{SUITS.join(', ')}/, error_msg.to_s
  end
end
