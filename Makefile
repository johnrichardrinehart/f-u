main: src/main.cc
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ \
		-std=c++20 \
		-lnixutil \
		-lnixexpr \
		-lnixmain \
		-lnixstore \
		-lnixfetchers \
		-o f-u++
