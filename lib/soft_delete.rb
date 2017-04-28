module SoftDelete
  def soft_delete
    self.deleted = 1
    self.deleted_at = Time.now
    associated_models!
    self.save
    freeze
  end

  def hard_delete
    self.destroy
  end

  def associated_models!
    check_models.each do |model|
      model_name = model.name.pluralize.downcase.to_s
      self.send(model_name).each { |m| m.soft_delete_association! }
    end
  end

  def check_models
    ActiveRecord::Base.send(:subclasses).select { |m| m.method_defined?(:soft_delete_association!)}
  end
end
