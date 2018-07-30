#!/usr/bin/ruby

# Find the longest common prefix, given a list of words.

def find_common_prefix(hash, acc)

    return acc if !hash

    if (hash.size == 1)
        key   = hash.keys[0]
        value = hash.values[0]
        return find_common_prefix(value, acc + key)
    end

    return acc
end

def lcp(strs)
    hash = {}

    for str in (strs.sort_by {|t| t.size })
        ref = hash
        return "" if str.empty?
        for char in (str.chars)
            if (ref.has_key?(char))
                ref = ref[char]
                break if (ref.size == 0)
            else
                ref = (ref[char] = {})
            end
        end
    end

    return find_common_prefix(hash, '')
end

tests = [
  ["interspecies","interstellar","interstate"],
  ["throne","throne"],
  ["throne","dungeon"],
  ["throne","","throne"],
  ["cheese"],
  [""],
  [],
  ["prefix","suffix"],
  ["foo","foobar"]
]

for test in tests
    puts "lcp(#{test}) = \"#{lcp(test)}\""
end
