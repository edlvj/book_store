module CurrentOrder
  extend ActiveSupport::Concern

  included do  
    def add_order_item(book_id, quantity = 1)
      item = order_items.find_by(book_id: book_id)
      if item
        item.increment :qty, quantity
      else
        order_items.new(qty: quantity, book_id: book_id)
      end
    end
    
    def set_order!(order)
      return self if self == order
      order.order_items.each do |order_item|
        add_order_item(order_item.book_id, order_item.qty).save
      end
      self.coupon = nil if order.coupon.present?
      order.destroy && order.coupon&.update_attributes(order: self)
      tap(&:save)
    end
    
    def items_count
      order_items.map(&:qty).sum
    end
    
    def sub_total
      order_items.map(&:sub_total).sum
    end
    
    def coupon_total
      coupon ? sub_total * (coupon.discount / 100.0) : 0.00
    end
    
    def shipping_total
      shipping ? shipping.costs : 0.00
    end  
    
    def total_cost
      sub_total - coupon_total + shipping_total
    end
  end  
end