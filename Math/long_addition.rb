#!/usr/bin/ruby

# A simple long addition algorithm to add two base-10 strings.

def long_addition(a,b)

    a = a.reverse.chars.map{|c| c.to_i }
    b = b.reverse.chars.map{|c| c.to_i }

    l = [a.size, b.size].max
    c = [0] * (l+1)

    (l - a.size).times { a << 0 }
    (l - b.size).times { b << 0 }

    for i in (0 .. l-1)
        c[i] += (a[i] + b[i])

        if (c[i] >= 10)
            c[i+1] = c[i]/10
            c[i] %= 10
        end
    end

    c.pop while (c[-1] == 0 and c.size > 1)
    c.join.reverse
end

puts long_addition("726543009768266516584962991253", "676316691562960674239642216436")       #=> 1402859701331227190824605207689
