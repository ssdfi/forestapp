class ValidacionesController < ApplicationController
  before_action :set_plantacion
  before_action :set_validacion, only: [:show, :edit, :update, :destroy]

  # GET /validaciones
  # GET /validaciones.json
  def index
    redirect_to @plantacion
  end

  # GET /validaciones/1
  # GET /validaciones/1.json
  def show
  end

  # GET /validaciones/new
  def new
    @validacion = @plantacion.validaciones.new
  end

  # GET /validaciones/1/edit
  def edit
  end

  # POST /validaciones
  # POST /validaciones.json
  def create
    @validacion = @plantacion.validaciones.new(validacion_params)

    respond_to do |format|
      if @validacion.save
        format.html { redirect_to [@plantacion, @validacion], notice: 'Validación creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: [@plantacion, @validacion] }
      else
        format.html { render :new }
        format.json { render json: @validacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /validaciones/1
  # PATCH/PUT /validaciones/1.json
  def update
    respond_to do |format|
      if @validacion.update(validacion_params)
        format.html { redirect_to [@plantacion, @validacion], notice: 'Validació actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: [@plantacion, @validacion] }
      else
        format.html { render :edit }
        format.json { render json: @validacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /validaciones/1
  # DELETE /validaciones/1.json
  def destroy
    @validacion.destroy
    respond_to do |format|
      format.html { redirect_to plantacion_validaciones_url(@plantacion, @validacion), notice: 'Validación eliminada satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plantacion
      @plantacion = Plantacion.find(params[:plantacion_id])
    end

    def set_validacion
      @validacion = Validacion.find(params[:id] || params[:validacion_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def validacion_params
      params.require(:validacion).permit(:plantacion_id, :responsable_id, :especie_1_id, :especie_2_id, :especie_3_id,
        :edad_estimada, :densidad_estimada, :dap_promedio, :altura_media_dominante, :numero_poda, :numero_raleo,
        :cantidad_poda, :cantidad_raleo, :sistematizacion_id, :distancia_filas, :distancia_plantas)
    end
end
