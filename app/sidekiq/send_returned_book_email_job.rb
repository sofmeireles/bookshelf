class SendReturnedBookEmailJob
  include Sidekiq::Job
  sidekiq_options queue: 'critical'


  def perform(reserver_id, recipient_id, book_id)
    reserver = User.find(reserver_id)
    recipient = User.find(recipient_id)
    book = Book.find(book_id)

    AdminMailer.with(reserver: reserver, recipient: recipient, book: book)
              .returned_book
              .deliver_now
  end
end