class AddI18nToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :i18n, :string, default: nil
  end
end
