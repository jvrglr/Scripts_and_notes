# Table of Contents
1. [Hello world program](# Hello world program)
2. [Pointers, arrays, variables](# Pointers, arrays, variables)
3. [strings](# strings)
4. [Switch & if](# Switch & if)
5. [cin](# cin)
6. [vector](# vector)
7. [Loops](# Loops)
8. [Operators](# Operators)
9. [Exceptions](# Exceptions)
10. [Read/write on files](# Read/write on files)
11. [Compilers](# Compilers)
11. [Functions](# Functions)
12. [Using directive](# Using directive)

# Hello world program

```
#include <iostream> // Use standard library
using namespace std; // shortcut instead of std::cout

int main(/* arguments */) { // Main is always an int function!
  cout << "Hello, world" << '\n';
  return 0; // if main returns a value !=0 -> failure in the program
}
```

# Pointers, arrays, variables
http://www.cplusplus.com/doc/tutorial/pointers/
https://www.tutorialspoint.com/cplusplus/cpp_pointers.htm
```
char v[10]; // array of 10 characters (v[0],...,v[9])
char *p;  // char pointer p = &v[3] points to the fourth element of v
```
size_t is an unsigned type. So, it cannot represent any negative values(<0). You use
it when you are counting something, and are sure that it cannot be negative

# strings
```
string c="something" // correct: std::string
//it is possible to sum strings
cout << c + "another something" + "\n"
//operations on string:
c.substr(i,j) // create sub string from c of length j starting from i
c.replace(0,5,a) //replaces the sub string of length 5 starting from
//0 with the string a

```
# Switch & if
```
switch(ch) {
case  "p": // compares ch with p, if ch==p, then execute something
  //something
  break; //gets out of switch
case ...
default: //execute something if no case was successful
  //something
}
```

# cin
```
//By default, a white space when introducing a string from the keyboard
// ends the reading operation. We have to use getline
str a;
cin >> a; // type "something something"
cout << a; // shows "something"
getline(cin, str);type "something something"
cout << a // shows "something something"
```
# vector
http://www.cplusplus.com/reference/vector/vector/

"Compared to arrays, vectors consume more memory in exchange for the ability
to manage storage and grow dynamically in an efficient way."

"Compared to the other dynamic sequence containers
(deques, lists and forward_lists), vectors are very
efficient accessing its elements (just like arrays)
and relatively efficient adding or removing elements from its end.
For operations that involve inserting or removing elements at positions other than the end, they perform worse than the others, and have less
consistent iterators and references than lists and forward_lists."

```
#include <vector>

struct entrada{
  string nombre;
  int numero
}

vector<entrada> agenda(1000) // Define a variable with 1000
// elements. it has the "entrada" structure.
// vector<entrada> agenda[1000] are 1000 empty vectors

// Print structure

void  print_entrada(int i){
  cout << agenda[i].nombre << ' '  << agenda[i].numero << "\n"
}

// vector can be resized
void add_entries(int i){
agenda.resize(agenda.size()+i) // .size() compute length of vector
}

// vector will not check range violations--> type "vec" pg. 54

// operations
agenda.push_back(something) // Add element at the end
agenda.pop_back() // Delete last element

//print vector with c++11
std::cout << "infec_list=" << " ";
for (auto i = infec_list.begin(); i != infec_list.end(); ++i)
  std::cout << *i << ' ';
std::cout << '\n';

```
# Loops

```
while (condition) {
  // something
}

for (int i=0; i<10 ; i++){
  //something
}
```

# Operators
```
i+=1; // the same as i=i+1
```

# Exceptions
http://www.cplusplus.com/doc/tutorial/exceptions/
```
try {
  // code here
}
catch (int param) { cout << "int exception"; }
catch (char param) { cout << "char exception"; }
catch (...) { cout << "default exception"; }
```

# Read/write on files
http://www.cplusplus.com/doc/tutorial/files/
```
// basic file operations
#include <iostream>
#include <fstream>
using namespace std;

int main () {
  ofstream myfile;
  myfile.open ("example.txt");
  myfile << "Writing this to a file.\n";
  myfile.close();
  return 0;
}

# Compilers

gcc --> treats .c files as C programs and .cc as C++. To compile as C++ regardless to its extension use "gcc program_name -lstdc++". -lstdc++ includes standard c++ library.

g++ --> compiles everything as C++ as default.
```
# Functions

```
extern double Real_rand012(); // Declare it before int main(){}


double Real_rand012(){ // Define it after int main(){}
  std::random_device rd{}; // random seed
  std::mt19937 generator {rd()}; //engine that generates rd entire [0,2^32-1]
  std::uniform_real_distribution<double> Randreal01{0.0, 1.0}; // distribution

  return Randreal01(generator);
}
```

Static variables!

# Using directive

https://www.codeguru.com/cpp/cpp/cpp_mfc/stl/article.php/c4027/C-Tutorial-A-Beginners-Guide-to-stdvector-Part-1.htm

"This is okay for small projects, as long as you write the using directive in your cpp
file. Never write a using directive into a header file! This would bloat the entire
namespace std into each and every cpp file that includes that header.
 For larger projects, it is better to explicitly qualify every name accordingly."

"Note that for bigger projects it can be tedious to repeatedly write
out the explicit type of the vectors. You may use a typedef if you want:"

```
typedef std::vector<int> int_vec_t;    // or whatever you
                                       // want to name it
//...
int_vec_t v;
```
