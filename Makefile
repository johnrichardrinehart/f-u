main: src/main.cc
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ \
		-lnixutil \
		-lnixexpr \
		-lnixmain \
		-lnixstore \
		-lnixfetchers \
		-std=c++20 \
		-o f-u++
