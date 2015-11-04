class Permission < ActiveRecord::Base
  belongs_to :permissable, polymorphic: true
  after_save :cleanse_unneeded_permissions

  protected
    def cleanse_unneeded_permissions
      Permission.destroy_all(:level => 100)
    end
end
