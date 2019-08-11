operation HelloQ(name: String) : Unit {

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

open Microsoft.Quantum.Math;

/// # Summary
/// Sets the qubit's state to |+⟩
operation SetPlus(q: Qubit) : Unit {
    Reset(q);
    H(q);
}

/// # Summary
/// Sets the qubit's state to |-⟩
operation SetMinus(q: Qubit) : Unit {
    Reset(q);
    X(q);
    H(q);
}

/// # Summary
/// Randomly prepares the qubit into |+⟩ or |-⟩
operation PrepareRandomMessage(q: Qubit) : Unit {

    let choice = RandomInt(2);

    if (choice == 0) {
        Message("Prepared |-⟩");
        SetMinus(q);
    } else {
        Message("Prepared |+⟩");
        SetPlus(q);
    }
}

open Microsoft.Quantum.Diagnostics;
open Microsoft.Quantum.Measurement;

operation NextRandomBit() : Result {
    using (q = Qubit()) {
        SetPlus(q);
        return MResetZ(q);
    }
}

operation TestPrepareQubits() : Result {
    mutable r = Zero;
    
    using (qubits = Qubit[5]) {
        ApplyToEach(PrepareRandomMessage, qubits);
        DumpMachine();
        
        set r = Measure([PauliX, PauliX, PauliX, PauliX, PauliX], qubits);
        
        ResetAll(qubits);
    }
    
    return r;
}

%simulate HelloPi

%simulate NextRandomBit

%simulate TestPrepareQubits

%estimate TestPrepareQubits


