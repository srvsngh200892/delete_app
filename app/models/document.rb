class Document < ActiveRecord::Base
  include ChildSoftDelete
  belongs_to :task
  default_scope -> { where(deleted_at: nil , deleted: 0) }
end
