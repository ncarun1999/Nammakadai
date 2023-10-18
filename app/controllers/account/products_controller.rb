class Account::ProductsController < AuthenticatedController
  before_action :set_product, only: [:show]
  def index
    @products = current_account.products
  end

  def new
    @product = current_account.products.new
  end

  def show
  end

  def create
    @product = current_account.products.new product_params
    @product.created_by = current_user

    if @product.save
      flash[:success] = "Product #{@product.name} created successfully"
      redirect_to products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      render :'account/products/new'
    end
  end

  private

  def product_params
    params.require(:account_product).permit(:name, :description, :short_description, :cost, :price, :alias, images: [])
  end

  def set_product
    @product = current_account.products.find(params[:id])
  end
end
