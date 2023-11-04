class ProductsController < AuthenticatedController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :process_images, only: %i[update]

  def index
    @products = current_account.products
  end

  def new
    @product = current_account.products.new
  end

  def show; end

  def create
    @product = current_account.products.new product_params
    @product.created_by = current_user

    if @product.save
      flash[:success] = "Product #{@product.name} created successfully"
      redirect_to products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = "Product #{@product.name} updated successfully"
      redirect_to products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :short_description, :cost, :price, :alias, :sku, :barcode, :status, :tags, :track_quantity,
      images: []
    )
  end

  def set_product
    @product = current_account.products.find(params[:id])
  end

  def process_images
    @product.images.attach(params[:product][:images]) if params[:product][:images].any?(&:present?)
    params[:product].delete(:images)

    remove_image_params = params[:account_product][:remove_images]
    remove_image_params&.each { |image_id| @product.images.find(image_id).purge }
    params[:product].delete(:remove_images)
  end
end
