* Make a profile
* Tour the profile: READ NUMBERS
* Metrics (overall, cpu, memory...)
	* Are these numbers ok for you?
* Call graph
	* Hot path
	* Is this a reasonable amount of time for this function?
* Function list
	* Calls, excl, incl
	* Expand: metrics (hover)
	* Expand: callees (time restricted to call)
	* Search
* Find the problem function
	* Hot path: theme()
	* moriarty_preprocess_page is long for a preprocess
	* Last custom function: loadAcademicFacultyNodes
	* Calling node_load 36 times! Could be multiple
