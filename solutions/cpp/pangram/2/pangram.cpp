#include "pangram.h"
#include <cctype>
#include <unordered_set>

namespace pangram {

bool is_pangram(const std::string& sentence){
    std::unordered_set<char> letters;
    for(char c : sentence) {
        if(std::isalpha(static_cast<unsigned char>(c))){
           letters.insert(std::tolower(static_cast<char>(c)));
        }
    }

    return letters.size() == 26;
}

}  // namespace pangram
