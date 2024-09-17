#!/bin/python3

def format_binary_string(binary_string):
  '''Remove \'0b\' from a binary string.'''

  if len(binary_string) > 2 and binary_string[0:2] == '0b':
    return binary_string[2:]
  
  return binary_string


def is_binary_string(string, verbose=False):
  '''Check if a string contains only 0s and 1s, except for
  the \'0b\' at the beginning of the string.
  '''
  
  if isinstance(string, BinaryString):
    return is_binary_string(string.binary_string)

  if not isinstance(string, str):
    if verbose:
      print('Failure: not a string.')
    return False

  skip = 0
  if len(string) > 2 and string[:2] == '0b':
    skip = 2
  for b in string[skip:]:
    if b not in ['0', '1']:
      if verbose:
        print('Failure: not a binary string.')  
      return False

  return True


class BinaryString():
  '''This class describes a string that contains only binary digits and
  supports several methods for bitwise operations as well.
  '''
  def __init__(self, string):
    if not is_binary_string(string):
      self.binary_string = None 
    else:
      if isinstance(string, BinaryString):
        self.binary_string = string.binary_string
      else:  
        self.binary_string = format_binary_string(string)

  def append(self, other):
    '''Concatenate another binary string to the end.'''
    other = BinaryString(other)
    if not is_binary_string(other):
      return None
    
    self.binary_string += other.binary_string

  def __getitem__(self, value):
    # value can be either int, tuple or slice.
    if isinstance(value, int):
      index = value
    elif isinstance(value, slice):
      index = value.start
    elif isinstance(value, tuple):
      index = value[0]

    if index >= len(self.binary_string):
      raise IndexError()

    return BinaryString(self.binary_string[value])

  def rotr(self, n):
    '''Rotate a binary string by n bits.'''
    
    rotred_binary_string = self.binary_string[-n:] + self.binary_string[:-n]
    
    return BinaryString(rotred_binary_string)

  def __xor__(self, other):
    '''XOR provided binary strings. If strings have different lengths,
    left zero padding is added to the shorter string.
    '''

    other = BinaryString(other)
    if not is_binary_string(other):
      return None
 
    binary_string1, length1 = self.binary_string, len(self.binary_string) 
    binary_string2, length2 = other.binary_string, len(other.binary_string)
    if length1 <= length2:
      binary_string1, binary_string2 = binary_string2, binary_string1
      length1, length2 = length2, length1
    binary_string2 = '0' * (length1 - length2) + binary_string2 

    xored_binary_string = ''
    for i in range(length1):
      if binary_string1[i] == binary_string2[i]:
        xored_bit = '0'
      else:
        xored_bit = '1'
      
      xored_binary_string = xored_binary_string + xored_bit

    return BinaryString(xored_binary_string)

  def __neg__(self):
    '''Execute bitwise NOT on a binary string.'''
    
    if not is_binary_string(self.binary_string):
      return None

    noted_binary_string = ''
    for b in self.binary_string:
      if b == '0':
        noted_bit = '1'
      else:
        noted_bit = '0'

      noted_binary_string = noted_binary_string + noted_bit
    
    return BinaryString(noted_binary_string)

  def __len__(self):
    return len(self.binary_string)

  def __bool__(self):
    return (self.binary_string is not None and is_binary_string(self)) == True

  def __repr__(self):
    return self.binary_string

  def __str__(self):
    return self.binary_string
