#include "pangram.hpp"
#include <cctype>
#include <unordered_set>

namespace pangram {

bool is_pangram(const std::string& sentence) {
        std::unordered_set<char> letters;

        for (char c : sentence) {
                if(std::isalpha(static_cast<unsigned char>(c))) {
                        letters.insert(std::tolower(static_cast<unsigned char>(c)));
                }
        }

     constexpr int alphabet_size = 26;
     return letters.size() == alphabet_size;

}

}
