class Account::ProductsController < AuthenticatedController
  before_action :set_product, only: %i[show edit update destroy]

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

  def edit; end

  def update
    process_images

    if @product.update product_params
      flash[:success] = "Product #{@product.name} updated successfully"
      redirect_to products_path
    else
      flash[:alert] = @product.errors.full_messages.join(', ')
      render :'account/products/edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:account_product).permit(
      :name, :description, :short_description, :cost, :price, :alias, :sku, :barcode, :status, :tags, :track_quantity,
      images: []
    # variants_attributes: %i[title description cost price alias]
    )
  end

  def set_product
    @product = current_account.products.find(params[:id])
  end

  def process_images
    @product.images.attach(params[:account_product][:images]) if params[:account_product][:images].any?(&:present?)
    params[:account_product].delete(:images)

    remove_image_params = params[:account_product][:remove_images]
    params[:account_product].delete(:remove_images)

    return unless remove_image_params

    remove_image_params.each do |image_id|
      @product.images.find(image_id).purge
    end
  end
end
