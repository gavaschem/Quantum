operation HelloQ(name: String) : Unit {

    // The following line will simply write a message to the console:
    Message($"Hello {name}!");

}

operation HelloGavaskar() : Unit {
    HelloQ("Gavaskar");
}

open Microsoft.Quantum.Math;

operation HelloPi() : Unit {
    let pi = Microsoft.Quantum.Convert.DoubleAsString(PI());
    HelloQ(pi);
}

%simulate HelloPi

open Microsoft.Quantum.Arithmetic


