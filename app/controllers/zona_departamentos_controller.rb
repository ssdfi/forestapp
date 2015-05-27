class ZonaDepartamentosController < ApplicationController
  before_action :set_zona
  before_action :set_zona_departamento, only: [:show, :edit, :update, :destroy]

  # GET /zona_departamentos
  # GET /zona_departamentos.json
  def index
    @zona_departamentos = @zona.zona_departamentos.order(:codigo)
  end

  # GET /zona_departamentos/1
  # GET /zona_departamentos/1.json
  def show
  end

  # GET /zona_departamentos/new
  def new
    @zona_departamento = @zona.zona_departamentos.new
  end

  # GET /zona_departamentos/1/edit
  def edit
  end

  # POST /zona_departamentos
  # POST /zona_departamentos.json
  def create
    @zona_departamento = @zona.zona_departamentos.new(zona_departamento_params)

    respond_to do |format|
      if @zona_departamento.save
        format.html { redirect_to [@zona, @zona_departamento], notice: 'Departamento was successfully created.' }
        format.json { render :show, status: :created, location: [@zona, @zona_departamento] }
      else
        format.html { render :new }
        format.json { render json: @zona_departamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zona_departamentos/1
  # PATCH/PUT /zona_departamentos/1.json
  def update
    respond_to do |format|
      if @zona_departamento.update(zona_departamento_params)
        format.html { redirect_to [@zona, @zona_departamento], notice: 'Departamento was successfully updated.' }
        format.json { render :show, status: :ok, location: [@zona, @zona_departamento] }
      else
        format.html { render :edit }
        format.json { render json: @zona_departamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zona_departamentos/1
  # DELETE /zona_departamentos/1.json
  def destroy
    @zona_departamento.destroy
    respond_to do |format|
      format.html { redirect_to zona_zona_departamentos_url(@zona), notice: 'Departamento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zona_departamento
      @zona_departamento = ZonaDepartamento.find(params[:id])
    end

    def set_zona
      @zona = Zona.find(params[:zona_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zona_departamento_params
      params.require(:zona_departamento).permit(:zona_id, :codigo, :descripcion, :codigo_indec)
    end
end
