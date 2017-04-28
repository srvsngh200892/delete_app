module ChildSoftDelete
  def soft_delete_association!
    self.deleted = 1
    self.deleted_at = Time.now
    self.save
  end
end
