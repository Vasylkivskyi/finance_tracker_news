class RenameTypePriceToLastPrice < ActiveRecord::Migration[6.1]
  def change
    rename_column(:stocks, :type_price, :last_price)
  end
end
