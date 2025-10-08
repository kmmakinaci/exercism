#include "pangram.hpp"

namespace pangram {

bool is_pangram(const std::string& sentence) {
        bool letters[26] = {false};

        for (char c : sentence){
                // Convert uppercase to lowe case
                if( c >= 'A' && c <= 'Z' ) {
                        c = c - 'A' + 'a';
                }

                if(c >= 'a' && c <= 'z') {
                        letters[c - 'a'] = true;
                }
        }

        for (int i = 0; i<26; i++){
                if (!letters[i]) {
                        return false;
                }
        }

        return true;
}

}
