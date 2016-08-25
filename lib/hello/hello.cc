#include "hello/hello.h"

#include <string>

namespace hello {

std::string message(std::string name) {
  return "Hello, " + name + "!";
}
}
