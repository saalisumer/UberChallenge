# UberChallenge

The app uses architecture inspired from RIB Architecture from Uber.
There are just two RIBs for this simple App.
1. Search RIB (Root RIB)
2. Search Result RIB

There is a Riblet class that holds the reference of the Router, Interactor, Presenter and View Controller. Builder is just a factory class which is not retained by any class.

Future Improvements:

	•	Application Model Synchronized Thread safe - Specially access to array
	•	Use of Core Data Stack to support offline viewing of searches
	•	Persistence of image on disk and timely pruning
	•	Use of Reactive Swift for communication within the code base
	•	Unit Test  / UI Test Coverage of the RIB Components and Network Calls
	•	Refactoring Network Class to move common boiler plate code to parent class
	•	Disk Caching of Images and pruning of images if not used for certain period of time
