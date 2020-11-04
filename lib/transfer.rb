class Transfer
  attr_reader :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if @status == "pending" && self.sender.balance > @amount && self.valid?
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
      @status = "reversed"
    end
  end

end
