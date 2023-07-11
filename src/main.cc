/*
 * Created in 2023 by Gaëtan Serré
 */

#include <iostream>
#include <filesystem>
#include <string>
using namespace std;
using namespace filesystem;

void system_call(const char* command) {
  printf("\033[96m+ %s\033[0m\n", command);
  system(command);
}

void make_lean_project(string lean_project_dir) {
  string lake_create_dir = "lake +leanprover/lean4:nightly-2023-02-04 new " + lean_project_dir + " math";

  system_call(lake_create_dir.c_str());

  // Go to the project directory
  current_path(lean_project_dir);

  string commands[] = {
    "lake update",
    "lake exe cache get"
  };

  for (string command : commands)
    system_call(command.c_str());

}

int main(int argc, char** argv) {

  if (argc < 2) {
    printf("\033[91mError: no project directory specified.\033[0m\n");
    printf("Usage: %s <project directory>\n", argv[0]);
    return 1;
  }

  string lean_project_dir = argv[1];

  make_lean_project(lean_project_dir);

  return 0;
}