class Task < ActiveRecord::Base
  include SoftDelete
  has_many :documents, :dependent => :destroy
  default_scope -> { where(deleted_at: nil , deleted: 0) }
end
