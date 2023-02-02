class BookSerializer < ActiveModel::Serializer
  attributes %i[id title author image_url comment description completed page_count published_at completed_at created_at updated_at]
end
