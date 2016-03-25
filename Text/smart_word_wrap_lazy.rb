#!/usr/bin/ruby

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 15th October 2013
# http://trizenx.blogspot.com
# http://trizenx.blogspot.ro/2013/11/smart-word-wrap.html
# Email: <echo dHJpemVueEBnbWFpbC5jb20K | base64 -d>

# Smart word wrap algorithm
# See: http://en.wikipedia.org/wiki/Word_wrap#Minimum_raggedness

class SmartWordWrap

    @width = 0

    # This is the ugliest method! It, recursively,
    # prepares the words for the combine() function.
    def prepare_words(array, depth=0)

        root = []
        len = 0
        i = -1

        limit = array.size-1
        while ((i+=1) <= limit)
            len += (word_len = array[i].size)

            if (len > @width)
                if (word_len > @width)
                    len -= word_len
                    array.insert(i-1, *(array[i].scan(/.{1,#{@width}}/m)))
                    array.delete_at(i)
                    limit = array.size-1
                    i -= 1; next
                end
                break
            end

            root << [
                array[0..i].join(' '), prepare_words(array[i+1 .. array.size-1], depth+1)
            ]

            if (depth == 0)
                yield(root[0])
                root = []
            end

            break if ((len += 1) >= @width)
        end

        root.size > 0 ? root : nil
    end

    # This function combines the
    # the parents with the childrens.
    def combine(root, path, block)
        key = path.shift
        path.each do |value|
            root << key
            if (value == nil)
                block[root]
            else
                value.each do |item|
                    combine(root, item, block)
                end
            end
            root.pop
        end
    end

    # This is the main function of the algorithm
    # which calls all the other functions and
    # returns the best possible wrapped string.
    def smart_wrap(text, width)

        @width = width
        words = text.is_a?(Enumerable) ? text : text.split(' ')

        best = {
            score: Float::INFINITY,
            value: [],
        }

        prepare_words(words) do |path|
            combine([], path, ->(combination) do
                score = 0
                combination.each do |line|
                    score += (@width - line.size)**2
                end

                if (score < best[:score])
                    best[:score] = score
                    best[:value] = combination+[]
                end
            end)
        end

        best[:value].join("\n")
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
