class ChangeFieldsInSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :want_to_learn, :text
    add_column :surveys, :participate_likelihood, :integer
    add_column :surveys, :use_quotes, :string
    remove_column :surveys, :recommendation_likelihood
  end
end
