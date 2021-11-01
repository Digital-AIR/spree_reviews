module Spree
  module Reviews
    class Find
      def initialize(scope:, params:)
        @scope = scope
        @products  = params.dig(:filter, :product_ids)&.split(',')
        @slug_products  = params.dig(:filter, :product_slugs)&.split(',')
        @approved  = params.dig(:filter, :approved)
        @order  = params.dig(:filter, :order_by)        
      end

      def execute
        reviews = by_product(scope)
        reviews = by_slug_product(reviews)
        reviews = by_approved(reviews)
        reviews = by_order(reviews)

        reviews
      end

      private

      attr_reader :slug_products, :products, :approved, :order, :scope

      def slug_products?
        slug_products.present?
      end
      
      def products?
        products.present?
      end

      def approved?
        approved.present?
      end

      def order?
        order.present?
      end

      def by_slug_product(reviews)
        return reviews unless slug_products?
        reviews.joins(:product).where(spree_products: {slug: slug_products})
      end

      def by_product(reviews)
        return reviews unless products?
        reviews.where(product_id: products)
      end

      def by_approved(reviews)
        return reviews unless approved?
        reviews.where(approved: approved)
      end

      def by_order(reviews)
        return reviews unless order?
        if order == 'latest'
          reviews.reorder("created_at DESC")
        elsif order == 'oldest'
          reviews.reorder("created_at ASC")
        elsif order == 'highest'
          reviews.reorder("rating DESC")
        elsif order == 'lowest'
          reviews.reorder("rating ASC")
        end        

      end
    end
  end
end