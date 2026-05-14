#!/usr/bin/ruby

# Count the number of bellow a given number n, using the Sieve of Eratosthenes.

# See also:
#   https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

def count_primes(n)

    return 0 if (n <= 2)

    a = [false, false, nil]

    for i in (2..Math.sqrt(n))
        next if (a[i] == false)
        k = i*i
        while (k <= n)
            a[k] = false
            k += i
        end
    end

    a.count {|n| n == nil }
end

puts count_primes(2)            #=> 0
puts count_primes(3)            #=> 1
puts count_primes(4)            #=> 2
puts count_primes(10)           #=> 4
puts count_primes(100)          #=> 25
puts count_primes(1000)         #=> 168
puts count_primes(10000)        #=> 1229
puts count_primes(1000000)      #=> 78498
puts count_primes(10000000)     #=> 664579
