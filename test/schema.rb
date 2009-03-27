ActiveRecord::Schema.define(:version => 0) do
  create_table :cards, :force => true do |t|
    t.integer :suit
  end
end
