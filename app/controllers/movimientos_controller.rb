class MovimientosController < ApplicationController
  before_action :set_movimiento, only: [:show, :edit, :update, :destroy]

  # GET /movimientos
  # GET /movimientos.json
  def index
    @movimientos = Movimiento.all
  end

  # GET /movimientos/1
  # GET /movimientos/1.json
  def show
    @actividades = @movimiento.actividades
  end

  # GET /movimientos/new
  def new
    @movimiento = Movimiento.new
  end

  # GET /movimientos/1/edit
  def edit
  end

  # POST /movimientos
  # POST /movimientos.json
  def create
    @movimiento = Movimiento.new(movimiento_params)

    respond_to do |format|
      if @movimiento.save
        format.html { redirect_to @movimiento, notice: 'Movimiento was successfully created.' }
        format.json { render :show, status: :created, location: @movimiento }
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
        format.html { redirect_to @movimiento, notice: 'Movimiento was successfully updated.' }
        format.json { render :show, status: :ok, location: @movimiento }
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
      format.html { redirect_to movimientos_url, notice: 'Movimiento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movimiento
      @movimiento = Movimiento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movimiento_params
      params.require(:movimiento).permit(:expediente_id, :numero_ficha, :inspector_id, :reinspector, :responsable_id, :anio_inspeccion, :destino_id, :fecha_entrada, :fecha_salida, :etapa, :observacion, :observacion_interna, :auditar, :validado)
    end
end
