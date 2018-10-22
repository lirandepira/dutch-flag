----------------------------- MODULE DutchFlag -----------------------------
EXTENDS Naturals, TLC

CONSTANT N      (* Size of arrays *)
CONSTANT MAXINT (* Max integer value *)

(* PlusCal options (-termination) *)

(*
--algorithm DutchFlag {
variables t \in [1..N->0..MAXINT];           (* Array of N integers in 0..MAXINT *)
          x \in 0..MAXINT;                               (* Value to find *)
          low \in 1..N;                                  (* This is the biggest red *)
          high \in 1..N;                                 (* This is the smallest blue *)
          mid = 1;
          temp = 0;
                   
(* Main *)
{     
        
    while (mid <= high) {
      if (t[mid] = 2) {
        mid := mid + 1;
        };
      else {
        if (t[mid] = 0) {
            temp := t[mid];
            t[mid] := t[low];
            t[low] := temp;
            low := low + 1;
            mid := mid + 1;
            };
          else {
            temp := t[mid];
            t[mid] := t[high];
            t[high] := temp;
            high := high - 1;
            };
        };
      };
            
    }
}
*)

\* BEGIN TRANSLATION
VARIABLES t, x, low, high, mid, temp, pc

vars == << t, x, low, high, mid, temp, pc >>

Init == (* Global variables *)
        /\ t \in [1..N->0..MAXINT]
        /\ x \in 0..MAXINT
        /\ low \in 1..N
        /\ high \in 1..N
        /\ mid = 1
        /\ temp = 0
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF mid <= high
               THEN /\ IF t[mid] = 2
                          THEN /\ mid' = mid + 1
                               /\ pc' = "Lbl_1"
                               /\ UNCHANGED << t, temp >>
                          ELSE /\ IF t[mid] = 0
                                     THEN /\ temp' = t[mid]
                                          /\ t' = [t EXCEPT ![mid] = t[low]]
                                          /\ pc' = "Lbl_2"
                                     ELSE /\ temp' = t[mid]
                                          /\ t' = [t EXCEPT ![mid] = t[high]]
                                          /\ pc' = "Lbl_3"
                               /\ mid' = mid
               ELSE /\ pc' = "Done"
                    /\ UNCHANGED << t, mid, temp >>
         /\ UNCHANGED << x, low, high >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ t' = [t EXCEPT ![low] = temp]
         /\ low' = low + 1
         /\ mid' = mid + 1
         /\ pc' = "Lbl_1"
         /\ UNCHANGED << x, high, temp >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ t' = [t EXCEPT ![high] = temp]
         /\ high' = high - 1
         /\ pc' = "Lbl_1"
         /\ UNCHANGED << x, low, mid, temp >>

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Mon Oct 22 13:51:30 CEST 2018 by lirandepira
\* Created Thu Oct 18 11:31:21 CEST 2018 by lirandepira
