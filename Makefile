main: src/main.cc
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ \
		-lnixutil \
		-lnixexpr \
		-lnixmain \
		-std=c++20 \
		-o f-u++
