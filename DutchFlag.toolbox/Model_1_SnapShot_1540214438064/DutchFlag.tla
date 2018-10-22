----------------------------- MODULE DutchFlag -----------------------------
EXTENDS Naturals, TLC

CONSTANT N      (* Size of arrays *)
CONSTANT MAXINT (* Max integer value *)


(* PlusCal options (-termination) *)

(*
--algorithm DutchFlag {
variables t \in [1..N->0..MAXINT];           (* Array of N integers in 0..MAXINT *)
          low \in 1..MAXINT;                 (* This is the biggest red *)
          high \in low+1..MAXINT;            (* This is the smallest blue *)
          mid = 1;
          temp = 0;
          left = 1;
          right = N;
                   
(* Main *)
{
    print <<t>>;    
        
    while (mid <= right) {
      assert(left <= mid);
      assert(mid <= right);
      if (/\ low < t[mid] /\ t[mid] < high) {
        mid := mid + 1;
        };
      else {
        if (t[mid] <= low) {
            temp := t[mid];
            t[mid] := t[left];
            t[left] := temp;
            left := left + 1;
            mid := mid + 1;
            };
          else {
            temp := t[mid];
            t[mid] := t[right];
            t[right] := temp;
            right := right - 1;
            };
        };
      };
          assert( \E i \in 1..N : \A j \in 1..N : j < i => t[j] <= low );
          assert( \E i \in 1..N : \A j \in 1..N : j > i => t[j] >= high );
          
    }
}
*)

\* BEGIN TRANSLATION
VARIABLES t, low, high, mid, temp, left, right, pc

vars == << t, low, high, mid, temp, left, right, pc >>

Init == (* Global variables *)
        /\ t \in [1..N->0..MAXINT]
        /\ low \in 1..MAXINT
        /\ high \in low+1..MAXINT
        /\ mid = 1
        /\ temp = 0
        /\ left = 1
        /\ right = N
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ PrintT(<<t>>)
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << t, low, high, mid, temp, left, right >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF mid <= right
               THEN /\ Assert((left <= mid), 
                              "Failure of assertion at line 25, column 7.")
                    /\ Assert((mid <= right), 
                              "Failure of assertion at line 26, column 7.")
                    /\ IF /\ low < t[mid] /\ t[mid] < high
                          THEN /\ mid' = mid + 1
                               /\ pc' = "Lbl_2"
                               /\ UNCHANGED << t, temp >>
                          ELSE /\ IF t[mid] <= low
                                     THEN /\ temp' = t[mid]
                                          /\ t' = [t EXCEPT ![mid] = t[left]]
                                          /\ pc' = "Lbl_3"
                                     ELSE /\ temp' = t[mid]
                                          /\ t' = [t EXCEPT ![mid] = t[right]]
                                          /\ pc' = "Lbl_4"
                               /\ mid' = mid
               ELSE /\ Assert(( \E i \in 1..N : \A j \in 1..N : j < i => t[j] <= low ), 
                              "Failure of assertion at line 46, column 11.")
                    /\ Assert(( \E i \in 1..N : \A j \in 1..N : j > i => t[j] >= high ), 
                              "Failure of assertion at line 47, column 11.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << t, mid, temp >>
         /\ UNCHANGED << low, high, left, right >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ t' = [t EXCEPT ![left] = temp]
         /\ left' = left + 1
         /\ mid' = mid + 1
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << low, high, temp, right >>

Lbl_4 == /\ pc = "Lbl_4"
         /\ t' = [t EXCEPT ![right] = temp]
         /\ right' = right - 1
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << low, high, mid, temp, left >>

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_4
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Mon Oct 22 15:20:10 CEST 2018 by lirandepira
\* Created Thu Oct 18 11:31:21 CEST 2018 by lirandepira
