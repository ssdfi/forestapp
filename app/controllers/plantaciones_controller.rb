class PlantacionesController < ApplicationController
  before_action :set_plantacion, only: [:show, :edit, :update, :destroy, :map]

  # GET /plantaciones
  # GET /plantaciones.json
  def index
    @plantaciones = Plantacion.all
  end

  # GET /plantaciones/1
  # GET /plantaciones/1.json
  def show
    @expedientes = @plantacion.expedientes.page params[:page]
  end

  # GET /plantaciones/1/map
  def map
    @geojson = @plantacion.to_geojson
  end

  # GET /plantaciones/new
  def new
    @plantacion = Plantacion.new
  end

  # GET /plantaciones/1/edit
  def edit
  end

  # POST /plantaciones
  # POST /plantaciones.json
  def create
    @plantacion = Plantacion.new(plantacion_params)

    respond_to do |format|
      if @plantacion.save
        format.html { redirect_to @plantacion, notice: 'Plantacion was successfully created.' }
        format.json { render :show, status: :created, location: @plantacion }
      else
        format.html { render :new }
        format.json { render json: @plantacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plantaciones/1
  # PATCH/PUT /plantaciones/1.json
  def update
    respond_to do |format|
      if @plantacion.update(plantacion_params)
        format.html { redirect_to @plantacion, notice: 'Plantacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @plantacion }
      else
        format.html { render :edit }
        format.json { render json: @plantacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plantaciones/1
  # DELETE /plantaciones/1.json
  def destroy
    @plantacion.destroy
    respond_to do |format|
      format.html { redirect_to plantaciones_url, notice: 'Plantacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plantacion
      @plantacion = Plantacion.find(params[:id] || params[:plantacion_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plantacion_params
      params[:plantacion]
    end
end
