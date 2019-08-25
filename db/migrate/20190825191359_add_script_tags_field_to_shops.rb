class AddScriptTagsFieldToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :vars_script_tag, :string
    add_column :shops, :dcs_script_tag, :string
  end
end
