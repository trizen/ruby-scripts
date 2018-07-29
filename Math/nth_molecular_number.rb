#!/usr/bin/ruby

# Generate the n-th molecular number that is the product of a subset of primes given.

# For primes = [2,3,5], the n-th molecular number is the n-th 5-smooth number.

# See also:
#   https://en.wikipedia.org/wiki/Regular_number
#   https://en.wikipedia.org/wiki/Smooth_number

def molecule_generator(atoms)

    s = []
    atoms.size.times { s << [1] }

    lambda {
        n = s.map {|t| t[0] }.min
        atoms.size.times { |i|
            s[i] = [] unless s[i]
            s[i].shift if (s[i][0] == n)
            s[i] << (n * atoms[i])
        }
        return n
    }
end

def nth_molecular_number(n, atoms)
    g = molecule_generator(atoms)
    (n-1).times { g.call }
    g.call
end

puts nth_molecular_number(12, [2,7,13,19])
puts nth_molecular_number(25, [2,5,7,11,13,23,29,31,53,67,71,73,79,89,97,107,113,127,131,137])
puts nth_molecular_number(100000, [7,19,29,37,41,47,53,59,61,79,83,89,101,103,109,127,131,137,139,157,167,179,181,199,211,229,233,239,241,251])
