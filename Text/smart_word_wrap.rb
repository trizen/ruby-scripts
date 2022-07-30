#!/usr/bin/ruby

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 15th October 2013
# https://trizenx.blogspot.com
# https://trizenx.blogspot.com/2013/11/smart-word-wrap.html

# Smart word wrap algorithm
# See: https://en.wikipedia.org/wiki/Word_wrap#Minimum_raggedness

class SmartWordWrap

    @width = 0;

    # This is the ugliest method! It, recursively,
    # prepares the words for the combine() function.
    def prepare_words(array)

        root = []
        len = 0

        i = -1
        limit = array.size-1
        while ((i+=1) <= limit)
            len += (word_len = array[i].size)

            if len > @width
                if word_len > @width
                    len -= word_len
                    value = array[i]
                    array.delete_at(i)
                    array.insert(i, *(value.scan(/.{1,#{@width}}/m)))
                    limit = array.size-1
                    i -= 1; next
                end
                break
            end

            root << [
                array[0..i].join(' '),
                prepare_words(array[i+1 .. limit])
            ]
            break if ((len += 1) >= @width)
        end

        root
    end

    # This function combines the
    # the parents with the childrens.
    def combine(root, path)

        row = []
        key = path.shift
        path.each do |value|
            root << key
            if value.empty?
                row = [root + []]
            else
                value.each do |item|
                    row += combine(root, item)
                end
            end
            root.pop
        end

        row
    end

    # This function finds the best
    # combination available and returns it.
    def find_best(arrays)

        best = {
            score: Float::INFINITY,
            value: [],
        }

        arrays.each { |array|
            score = 0;
            array.each { |line|
                score += (@width - line.size)**2
            }

            if score < best[:score]
                best[:score] = score
                best[:value] = array
            end
        }

        best[:value]
    end

    # This is the main function of the algorithm
    # which calls all the other functions and
    # returns the best possible wrapped string.
    def smart_wrap(text, width)

        @width = width;
        words = text.is_a?(Enumerable) ? text : text.split(' ')

        lines = [];
        self.prepare_words(words).each { |path|
            lines += combine([], path)
        }

        best = self.find_best(lines)
        best == nil and return nil
        return best.join("\n")
    end

end

#
## Usage examples
#

text = 'aaa bb cc ddddd'
obj = SmartWordWrap.new

puts obj.smart_wrap(text, 6)

puts '-'*80

text = 'As shown in the above phases (or steps), the algorithm does many useless transformations'
puts obj.smart_wrap(text, 20)

puts '-'*80

text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
puts obj.smart_wrap(text, 20)
