#include <gtest/gtest.h>
#include "pangram.hpp"

using namespace pangram;

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

TEST(PangramTest, EmptyStringIsNotPangram) {
    EXPECT_FALSE(is_pangram(""));
}

TEST(PangramTest, ClassicPangram) {
    EXPECT_TRUE(is_pangram("The quick brown fox jumps over the lazy dog"));
}

TEST(PangramTest, MissingLetter) {
    EXPECT_FALSE(is_pangram("The quick brown fox jumps over the lay dog"));
}

TEST(PangramTest, AllLettersUppercase) {
    EXPECT_TRUE(is_pangram("ABCDEFGHIJKLMNOPQRSTUVWXYZ"));
}

TEST(PangramTest, MixedCaseAndPunctuation) {
    EXPECT_TRUE(is_pangram("Pack my box with five dozen liquor jugs!"));
}

TEST(PangramTest, NonAlphabeticCharactersIgnored) {
    EXPECT_TRUE(is_pangram("1234567890abcdefghijklmnopqrstuvwxyz!@#$%^&*()"));
}

TEST(PangramTest, RepeatedLetters) {
    EXPECT_TRUE(is_pangram("aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz"));
}