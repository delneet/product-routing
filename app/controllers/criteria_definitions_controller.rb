class CriteriaDefinitionsController < ApplicationController
  before_action :set_criteria_definition, only: [:show, :edit, :update, :destroy]

  # GET /criteria_definitions
  def index
    @criteria_definitions = CriteriaDefinition.all
  end

  # GET /criteria_definitions/1
  def show
  end

  # GET /criteria_definitions/new
  def new
    @criteria_definition = CriteriaDefinition.new
  end

  # GET /criteria_definitions/1/edit
  def edit
  end

  # POST /criteria_definitions
  def create
    @criteria_definition = CriteriaDefinition.new(criteria_definition_params)

    respond_to do |format|
      if @criteria_definition.save
        format.html { redirect_to @criteria_definition, notice: "Criteria definition was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /criteria_definitions/1
  def update
    respond_to do |format|
      if @criteria_definition.update(criteria_definition_params)
        format.html { redirect_to @criteria_definition, notice: "Criteria definition was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /criteria_definitions/1
  def destroy
    @criteria_definition.destroy
    respond_to do |format|
      format.html { redirect_to criteria_definitions_url, notice: "Criteria definition was successfully destroyed." }
    end
  end

  private

  def set_criteria_definition
    @criteria_definition = CriteriaDefinition.find(params[:id])
  end

  def criteria_definition_params
    params.require(:criteria_definition).permit(:max_product_price, :destination, product_references: [], product_categories: [])
  end
end
