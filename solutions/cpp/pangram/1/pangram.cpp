#include "pangram.h"
#include <string>
#include <cctype>

namespace pangram {

bool is_pangram(const std::string& sentence){
    bool letters[26] = {false}; //track each letter

    for(char c : sentence) {
        if(isalpha(c)){
            c = tolower(c);
            letters[c-'a'] = true;
        }
    }

    for(int i = 0; i<26; i++){
        if(!letters[i]){
            return false;
        }
    }

    return true;
}

}  // namespace pangram
