----------------------------- MODULE DutchFlag -----------------------------
EXTENDS Naturals, TLC

CONSTANT N      (* Size of arrays *)
CONSTANT MAXINT (* Max integer value *)


(* PlusCal options (-termination) *)

(*
--algorithm DutchFlag {
variables t \in [1..N->0..MAXINT];           (* Array of N integers in 0..MAXINT *)
          low \in 1..MAXINT;                                  (* This is the biggest red *)
          high \in low..MAXINT;                                 (* This is the smallest blue *)
          mid = 1;
          temp = 0;
          l = 1;
          r = N;
                   
(* Main *)
{
    print <<t>>;    
        
    while (mid <= high) {
      if (t[mid] = 2) {
        mid := mid + 1;
        };
      else {
        if (t[mid] = 0) {
            temp := t[mid];
            t[mid] := t[l];
            t[l] := temp;
            l := l + 1;
            mid := mid + 1;
            };
          else {
            temp := t[mid];
            t[mid] := t[r];
            t[r] := temp;
            r := r - 1;
            };
        };
      };
          assert( \E i \in 1..N : \A j \in 1..N : j < i => t[j] <= low );
          assert( \E i \in 1..N : \A j \in 1..N : j > i => t[j] >= high );
          
    }
}
*)

\* BEGIN TRANSLATION
VARIABLES t, low, high, mid, temp, l, r, pc

vars == << t, low, high, mid, temp, l, r, pc >>

Init == (* Global variables *)
        /\ t \in [1..N->0..MAXINT]
        /\ low \in 1..MAXINT
        /\ high \in low..MAXINT
        /\ mid = 1
        /\ temp = 0
        /\ l = 1
        /\ r = N
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ PrintT(<<t>>)
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << t, low, high, mid, temp, l, r >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF mid <= high
               THEN /\ IF t[mid] = 2
                          THEN /\ mid' = mid + 1
                               /\ pc' = "Lbl_2"
                               /\ UNCHANGED << t, temp >>
                          ELSE /\ IF t[mid] = 0
                                     THEN /\ temp' = t[mid]
                                          /\ t' = [t EXCEPT ![mid] = t[l]]
                                          /\ pc' = "Lbl_3"
                                     ELSE /\ temp' = t[mid]
                                          /\ t' = [t EXCEPT ![mid] = t[r]]
                                          /\ pc' = "Lbl_4"
                               /\ mid' = mid
               ELSE /\ Assert(( \E i \in 1..N : \A j \in 1..N : j < i => t[j] <= low ), 
                              "Failure of assertion at line 44, column 11.")
                    /\ Assert(( \E i \in 1..N : \A j \in 1..N : j > i => t[j] >= high ), 
                              "Failure of assertion at line 45, column 11.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << t, mid, temp >>
         /\ UNCHANGED << low, high, l, r >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ t' = [t EXCEPT ![l] = temp]
         /\ l' = l + 1
         /\ mid' = mid + 1
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << low, high, temp, r >>

Lbl_4 == /\ pc = "Lbl_4"
         /\ t' = [t EXCEPT ![r] = temp]
         /\ r' = r - 1
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << low, high, mid, temp, l >>

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_4
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Mon Oct 22 14:40:45 CEST 2018 by lirandepira
\* Created Thu Oct 18 11:31:21 CEST 2018 by lirandepira
