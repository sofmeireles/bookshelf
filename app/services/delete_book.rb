class DeleteBook
  Result = Struct.new(:success?, :book, :errors, keyword_init: true)

  def initialize(book)
      @book = book
  end

  def perform
      @book.destroy!

      Result.new( { success?: true, book: @book} )
  rescue ActiveRecord::RecordInvalid => error
      Result.new( {success?: false, errors: error.record.errors.full_messages} )
  end

  private

  attr_accessor :book
end