class SelectedStatus100
  extend Forwardable

  KEY_STATUS = 'status100'

  SIZE = 100
  INITIAL_STATUS = true

  class << self
    def one_side_array_of(bool)
      (0..SIZE-1).to_a.map{|idx| bool}
    end
  end

  def initialize(init_item)
    @status = case init_item
                when nil ; self.class.one_side_array_of(INITIAL_STATUS)
                when true, false ; self.class.one_side_array_of(init_item)
                else
                  if init_item.is_a?(Array) && init_item.size == SIZE
                    init_item
                  else
                    raise 'Invalid init_item in initialize'
                  end
              end
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    @status =
        decoder.decodeObjectForKey(KEY_STATUS) ||
            self.class.one_side_array_of(INITIAL_STATUS)
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(@status, forKey: KEY_STATUS)
  end

  def status_array
    @status
  end

  def_delegators :@status, :[], :[]=, :size, :each, :count, :inject

  def of_number(idx)
    raise "invalid index [#{idx}]" if idx < 1 || idx > SIZE
    self[idx-1]
  end

  def select_in_number(idx)
    set_status(true, of_number: idx)
    self
  end

  def cancel_in_number(idx)
    set_status(false, of_number: idx)
    self
  end

  def cancel_all
    @status = self.class.one_side_array_of(false)
    self
  end

  def select_all
    @status = self.class.one_side_array_of(true)
    self
  end

  def selected_num
    @status.select{|stat| stat}.size
  end

  def select_in_numbers(collection)
    collection.each {|idx| select_in_number(idx)}
  end

  def cancel_in_numbers(collection)
    collection.each {|idx| cancel_in_number(idx)}
  end

  def reverse_in_index(idx)
    self[idx] = !self[idx]
  end

  def reverse_in_number(num)
    reverse_in_index(num-1)
  end

  :private

  def set_status(value, of_number: idx)
    raise "invalid index [#{idx}]" if idx < 1 || idx > SIZE
    self[idx-1] = value
  end

end