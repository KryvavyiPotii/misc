#!/bin/python3

def to_bits(data, check=True):
  '''Convert str, list or tuple of bits to a bit string.'''
  
  bits = None

  if isinstance(data, BinaryString):
    bits = data.binary_string 
  elif isinstance(data, list) or isinstance(data, tuple):
    bits = ''.join(bits)
  elif isinstance(data, str):
    if len(data) > 2 and data[0:2] == '0b':
      bits = data[2:]
    else:
      bits = data
  
  if check and not is_bits(bits):
    return None
  else:
    return bits


def is_bits(data, verbose=False):
  '''Check if a string, list or tuple contains only 0s and 1s.'''
 
  data = to_bits(data, check=False)
  
  if not isinstance(data, str):
    if verbose:
      print('Failure: not a bit string.')
    return False

  for b in data:
    if b not in ['0', '1']:
      if verbose:
        print('Failure: not bits.')  
      return False

  return True


def concatenate_binary_strings(binary_string1, binary_string2):
  '''Concatenate two binary strings.'''

  binary_string1 = BinaryString(binary_string1)
  binary_string1.append(binary_string2)

  return binary_string1


def set_size(binary_string, size):
  '''Adjust (truncate or expand) the binary string.'''

  current_size = len(binary_string)
  if size > current_size:
    return BinaryString('0' * (size - current_size) + binary_string)
  else:
    return BinaryString(binary_string[current_size - size:])


def xor_of_bits(bits):
  '''Calculate XOR of all provided bits.'''
  
  bits = BinaryString(bits)
  if not bits:
    return None

  bit_sum = BinaryString('0')
  for b in bits:
    bit_sum ^= b 

  return bit_sum


class BinaryString():
  '''This class describes a string that contains only binary digits.
  It also supports multiple methods for bitwise operations as well.
  '''
  def __init__(self, data):
    self.binary_string = to_bits(data)

  def is_valid(self):
    return self.binary_string is not None

  def append(self, other):
    '''Add another binary string to the end. Modifies self.binary_string.'''
    
    other = BinaryString(other)

    self.binary_string += other.binary_string
 
  def rotr(self, n):
    '''Rotate right the binary string by n bits.'''
    
    rotred_binary_string = concatenate_binary_strings(self[-n:], self[:-n])
    
    return rotred_binary_string

  def __eq__(self, other):
    other = BinaryString(other)
    if not other.is_valid():
      return False

    return self.binary_string == other.binary_string

  def __getitem__(self, value):
    # value can be either int, tuple or slice.
    if isinstance(value, int):
      index = value
    elif isinstance(value, slice):
      index = value.start
    elif isinstance(value, tuple):
      index = value[0]

    if index and index >= len(self.binary_string):
      raise IndexError()

    return BinaryString(self.binary_string[value])

  def __xor__(self, other):
    '''XOR the binary strings. If they have different lengths,
    0s are added to the beginning of the shorter string.
    '''

    other = BinaryString(other)
    if not self.is_valid() or not other.is_valid():
      return None
 
    size = max([len(self), len(other)])
    binary_string1 = set_size(self.binary_string, size)
    binary_string2 = set_size(other.binary_string, size)

    xored_binary_string = ''
    for i in range(size):
      if binary_string1[i] == binary_string2[i]:
        xored_binary_string += '0'
      else:
        xored_binary_string += '1'

    return BinaryString(xored_binary_string)

  def __neg__(self):
    '''Execute bitwise NOT on the binary string.'''
    
    if not self.is_valid():
      return None

    noted_binary_string = ''
    for b in self:
      if b == '0':
        noted_binary_string += '1'
      else:
        noted_binary_string += '0'
    
    return BinaryString(noted_binary_string)

  def __len__(self):
    return len(self.binary_string)

  def __bool__(self):
    return self.is_valid() and int(self.binary_string, 2) != 0

  def __repr__(self):
    return self.binary_string

  def __str__(self):
    return self.binary_string
