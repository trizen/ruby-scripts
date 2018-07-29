#!/usr/bin/ruby

# Daniel "Trizen" Șuteu
# Date: 29 July 2018
# https://github.com/trizen

# A simple implementation of Lambert's W function in real numbers.

# Example: x^x = 100
#            x = exp(lambertW(log(100)))
#            x =~ 3.5972850235404...

# See also:
#   https://en.wikipedia.org/wiki/Lambert_W_function

def LambertW(c)

    x = (Math.sqrt(c) + 1)
    y = 0.0

    while ((x-y).abs > 1e-10)
        y = x
        x = ((x + c) / (1.0 + Math.log(x)))
    end

    Math.log(x)
end

puts Math.exp(LambertW(Math.log(100)))      #=> 3.5972850235404175
