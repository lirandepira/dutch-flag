----------------------------- MODULE DutchFlag -----------------------------
EXTENDS Naturals, TLC

CONSTANT N      (* Size of arrays *)
CONSTANT MAXINT (* Max integer value *)

(* PlusCal options (-termination) *)

(*
--algorithm DutchFlag {
variables t \in {f \in [ 1..N -> 0..MAXINT ]};           (* Array of N integers in 0..MAXINT *)
          x \in 0..MAXINT;              (* Value to find *)
          low \in 1..N;                        (* This is the biggest red *)
          high \in 1..N;                        (* This is the smallest blue *)
                   
(* Main *)
{     
    mid := 1;
    res := {f \in [ 1..N -> 0..MAXINT ]};
    print <<t, x>>;
        
    while (mid <= high) {
      if (t(mid) = 2) {
        mid := mid + 1;
        };
      else {
        if (t(mid) = 0) {
            res(low) := t(mid);
            res(mid) := t(low);
            low := low + 1;
            mid := mid + 1;
            };
          else {
            res(high) := t(mid);
            res(mid) := t(high);
            high := high - 1;
            };
        };
      };
            
    }
}
*)

\* BEGIN TRANSLATION
\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Thu Oct 18 19:43:56 CEST 2018 by lirandepira
\* Created Thu Oct 18 11:31:21 CEST 2018 by lirandepira
