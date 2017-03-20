ActiveAdmin.register Book do
  permit_params :title, :description, :price, :image, :category_id
  
  form(:html => { :multipart => true }) do |f|
   f.inputs "Create Product..." do
     f.input :title
     f.input :description
     f.input :price
     f.input :category_id, :as => :select, :collection => Category.all.collect {|category| [category.name, category.id] }
 #    f.input :author_id, :as => :select, :collection => Author.all.collect {|author| [author.first_name + " "+ author.last_name , author.id] }
     f.input :image, :as => :file
    end
    
    f.actions
  end
 
 
end
