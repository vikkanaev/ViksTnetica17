ThinkingSphinx::Index.define :comment, with: :active_record do
  # fileds
  indexes message

  # attributes
  has user_id, created_at, updated_at
end
