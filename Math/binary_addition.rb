#!/usr/bin/ruby

# A simple addition algorithm to add two binary-strings.

def add_binary(a,b)

    a = a.reverse.chars.map{|c| c.to_i }
    b = b.reverse.chars.map{|c| c.to_i }

    l = [a.size, b.size].max
    c = []

    (l+1).times { c << 0 }
    (l - a.size).times { a << 0 }
    (l - b.size).times { b << 0 }

    for i in (0 .. l-1)
        c[i] += (a[i] + b[i])

        if (c[i] >= 2)
            c[i+1] = c[i]>>1
            c[i] &= 1
        end
    end

    c.pop while (c[-1] == 0 and c.size > 1)
    c.join.reverse
end

puts add_binary("101110011101110010101010100001", "1101011110100111101111000100")       #=> 111011111100011010011001100101
