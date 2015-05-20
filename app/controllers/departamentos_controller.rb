class DepartamentosController < ApplicationController
  before_action :set_provincia
  before_action :set_departamento, only: [:show, :edit, :update, :destroy]

  # GET /departamentos
  # GET /departamentos.json
  def index
    @departamentos = @provincia.departamentos.order(:nombre)
  end

  # GET /departamentos/1
  # GET /departamentos/1.json
  def show
  end

  # GET /departamentos/new
  def new
    @departamento = @provincia.departamentos.new
  end

  # GET /departamentos/1/edit
  def edit
  end

  # POST /departamentos
  # POST /departamentos.json
  def create
    @departamento = @provincia.departamentos.new(departamento_params)

    respond_to do |format|
      if @departamento.save
        format.html { redirect_to [@provincia, @departamento], notice: 'Departamento was successfully created.' }
        format.json { render :show, status: :created, location: [@provincia, @departamento] }
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
        format.html { redirect_to [@provincia, @departamento], notice: 'Departamento was successfully updated.' }
        format.json { render :show, status: :ok, location: [@provincia, @departamento] }
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
      format.html { redirect_to provincia_departamentos_url(@provincia), notice: 'Departamento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departamento
      @departamento = Departamento.find(params[:id])
    end

    def set_provincia
      @provincia = Provincia.find(params[:provincia_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departamento_params
      params.require(:departamento).permit(:provincia_id, :nombre)
    end
end
