main: src/main.cc
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ -lnixutil -lnixexpr -std=c++20 -o f-u++
