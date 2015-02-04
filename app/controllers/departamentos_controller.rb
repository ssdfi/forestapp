class DepartamentosController < ApplicationController
  before_action :set_zona
  before_action :set_departamento, only: [:show, :edit, :update, :destroy]

  # GET /departamentos
  # GET /departamentos.json
  def index
    @departamentos = @zona.departamentos.order(:codigo)
  end

  # GET /departamentos/1
  # GET /departamentos/1.json
  def show
  end

  # GET /departamentos/new
  def new
    @departamento = @zona.departamentos.new
  end

  # GET /departamentos/1/edit
  def edit
  end

  # POST /departamentos
  # POST /departamentos.json
  def create
    @departamento = @zona.departamentos.new(departamento_params)

    respond_to do |format|
      if @departamento.save
        format.html { redirect_to [@zona, @departamento], notice: 'Departamento was successfully created.' }
        format.json { render :show, status: :created, location: [@zona, @departamento] }
      else
        format.html { render :new }
        format.json { render json: @departamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departamentos/1
  # PATCH/PUT /departamentos/1.json
  def update
    respond_to do |format|
      if @departamento.update(departamento_params)
        format.html { redirect_to [@zona, @departamento], notice: 'Departamento was successfully updated.' }
        format.json { render :show, status: :ok, location: [@zona, @departamento] }
      else
        format.html { render :edit }
        format.json { render json: @departamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departamentos/1
  # DELETE /departamentos/1.json
  def destroy
    @departamento.destroy
    respond_to do |format|
      format.html { redirect_to zona_departamentos_url(@zona), notice: 'Departamento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departamento
      @departamento = Departamento.find(params[:id])
    end

    def set_zona
      @zona = Zona.find(params[:zona_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departamento_params
      params.require(:departamento).permit(:zona_id, :codigo, :descripcion, :codigo_indec)
    end
end
