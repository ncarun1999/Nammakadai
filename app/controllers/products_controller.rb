class ProductsController < AuthenticatedController
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
    p product_params
    sd
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
    process_images

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
    # variants_attributes: %i[title description cost price alias]
    params.require(:product).permit(
      :name, :description, :short_description, :cost, :price, :alias, :sku, :barcode, :status, :tags, :track_quantity,
      images: [],
      option_names_attributes: [:name, option_values_attributes: [:name]]
    )
  end

  def set_product
    @product = current_account.products.find(params[:id])
  end

  def process_images
    @product.images.attach(params[:product][:images]) if params[:product][:images].any?(&:present?)
    params[:product].delete(:images)

    remove_image_params = params[:account_product][:remove_images]
    params[:product].delete(:remove_images)

    return unless remove_image_params

    remove_image_params.each do |image_id|
      @product.images.find(image_id).purge
    end
  end

  def process_option_values_attributes
    params[:product][:option_names_attributes].each do |_, option_name|
      option_name[:option_values_attributes].transform_values! do |value_attributes|
        value_attributes.reject! { |_, value| value.blank? }
      end
    end
  end
end
