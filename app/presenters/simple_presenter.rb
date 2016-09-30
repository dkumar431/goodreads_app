class SimplePresenter
  attr_reader :model

  def initialize model, view
    @model = model
    @view = view
  end

  private

  def h
    @view
  end
end

