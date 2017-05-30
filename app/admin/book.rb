ActiveAdmin.register Book do
  permit_params :title, :description, :price, :image, :category_id
  
  index as: ActiveAdmin::Views::IndexAsTable do
    selectable_column

    column :image, style: :thumb do |book|
      image_tag(book.image.url, :size => "200x250")
    end
    
    column :title, sortable: :title do |book|
      book.title
    end
    
    column :description, sortable: :title do |book|
      book.description
    end
    
    column :price, sortable: :price do |book|
      book.price
    end
    
    actions
  end
  
  form( html: { multipart: true }) do |f|
   f.inputs "Create Product..." do
     f.input :title
     f.input :description
     f.input :price
     f.input :pub_year
     f.input :dimension
     
     f.input :category_id, as: :select, collection: Category.all.collect {|category| [category.name, category.id] }
     f.input :image, as: :file
    end
    
    f.actions
  end
end
