/*
Author: Santiago Castillo
Date: 7/20/2025
*/

#include <iostream>
#include <string>
#include <unordered_map>
#include <fstream>
#include <sstream>
#include <regex>

// global maps
std::unordered_map<std::string, std::uint8_t> instructions;

// load maps from the textfiles
void load_map(const std::string& filename, std::unordered_map<std::string, std::uint8_t>& my_map) {
    std::ifstream infile(filename);
    std::string line;

    while (std::getline(infile, line)) {
        std::istringstream iss(line);
        std::string key;
        std::string value_str;

        if (std::getline(iss, key, ',') && std::getline(iss, value_str)) {
            uint8_t value = static_cast<uint8_t>(std::stoi(value_str));
            my_map[key] = value;
        }
    }

    infile.close();
}

int pc;

//vector to store all commands
std::vector<std::string> commands;

// input will be in the format: ./Assembler <filename.asm>

int main (int argc, char** argv){

    if (argc != 2) {
        std::cout << "usage: assembler prog.asm" << std::endl;
    }
    load_map("opcodes.txt", instructions);

    std::string input_file = argv[1];
    std::ifstream infile(input_file);

    if (!infile.is_open()) {
        std::cerr << "Error opening file: " << input_file << std::endl;
        return 1;
    }

    // assembler logic does here

    return 0;
}