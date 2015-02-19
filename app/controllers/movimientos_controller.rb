class MovimientosController < ApplicationController
  before_action :set_expediente
  before_action :set_movimiento, only: [:show, :edit, :update, :destroy]

  # GET /movimientos
  # GET /movimientos.json
  def index
    redirect_to @expediente
  end

  # GET /movimientos/1
  # GET /movimientos/1.json
  def show
    @actividades = @movimiento.actividades
  end

  # GET /movimientos/new
  def new
    @movimiento = @expediente.movimientos.new
  end

  # GET /movimientos/1/edit
  def edit
  end

  # POST /movimientos
  # POST /movimientos.json
  def create
    @movimiento = @expediente.movimientos.new(movimiento_params)

    respond_to do |format|
      if @movimiento.save
        format.html { redirect_to [@expediente, @movimiento], notice: 'Movimiento creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: [@expediente, @movimiento] }
      else
        format.html { render :new }
        format.json { render json: @movimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movimientos/1
  # PATCH/PUT /movimientos/1.json
  def update
    respond_to do |format|
      if @movimiento.update(movimiento_params)
        format.html { redirect_to [@expediente, @movimiento], notice: 'Movimiento actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: [@expediente, @movimiento] }
      else
        format.html { render :edit }
        format.json { render json: @movimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movimientos/1
  # DELETE /movimientos/1.json
  def destroy
    @movimiento.destroy
    respond_to do |format|
      format.html { redirect_to expediente_movimientos_url(@expediente, @movimiento), notice: 'Movimiento eliminado satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expediente
      @expediente = Expediente.find(params[:expediente_id])
    end

    def set_movimiento
      @movimiento = Movimiento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movimiento_params
      params.require(:movimiento).permit(:expediente_id, :numero_ficha, :inspector_id, :reinspector_id, :responsable_id,
        :anio_inspeccion, :destino_id, :validador_id, :fecha_entrada, :fecha_salida, :etapa, :estabilidad_fiscal, :observacion,
        :observacion_interna, :auditar)
    end
end
