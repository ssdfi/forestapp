class EspeciesController < ApplicationController
  before_action :set_especie, only: [:show, :edit, :update, :destroy]

  # GET /especies
  # GET /especies.json
  def index
    @especie = params[:especie] ? Especie.new(especie_params) : Especie.new

    @especies = Especie.search(@especie)
    @especies = @especies.order(updated_at: :desc)
    @especies = @especies.page(params[:page])
  end

  # GET /especies/1
  # GET /especies/1.json
  def show
  end

  # GET /especies/new
  def new
    @especie = Especie.new
  end

  # GET /especies/1/edit
  def edit
  end

  # POST /especies
  # POST /especies.json
  def create
    @especie = Especie.new(especie_params)

    respond_to do |format|
      if @especie.save
        format.html { redirect_to @especie, notice: 'Especie was successfully created.' }
        format.json { render :show, status: :created, location: @especie }
      else
        format.html { render :new }
        format.json { render json: @especie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /especies/1
  # PATCH/PUT /especies/1.json
  def update
    respond_to do |format|
      if @especie.update(especie_params)
        format.html { redirect_to @especie, notice: 'Especie was successfully updated.' }
        format.json { render :show, status: :ok, location: @especie }
      else
        format.html { render :edit }
        format.json { render json: @especie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /especies/1
  # DELETE /especies/1.json
  def destroy
    @especie.destroy
    respond_to do |format|
      format.html { redirect_to especies_url, notice: 'Especie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_especie
      @especie = Especie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def especie_params
      params.require(:especie).permit(:genero_id, :codigo_sp, :codigo, :nombre_cientifico, :nombre_comun, :inscripcion_inase)
    end
end
