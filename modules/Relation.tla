----------------------------- MODULE Relation ------------------------------
EXTENDS Naturals, FiniteSets

(***************************************************************************)
(* This module provides some basic operations on relations, represented    *)
(* as binary Boolean functions over some set S.                            *)
(***************************************************************************)

(***************************************************************************)
(* Is the relation R reflexive over S?                                     *)
(***************************************************************************)
IsReflexive(R, S) == \A x \in S : R[x,x]

(***************************************************************************)
(* Is the relation R irreflexive over set S?                               *)
(***************************************************************************)
IsIrreflexive(R, S) == \A x \in S : ~ R[x,x]

(***************************************************************************)
(* Is the relation R symmetric over set S?                                 *)
(***************************************************************************)
IsSymmetric(R, S) == \A x,y \in S : R[x,y] <=> R[y,x]

(***************************************************************************)
(* Is the relation R asymmetric over set S?                                *)
(***************************************************************************)
IsAsymmetric(R, S) == \A x,y \in S : ~(R[x,y] /\ R[y,x])

(***************************************************************************)
(* Is the relation R transitive over set S?                                *)
(***************************************************************************)
IsTransitive(R, S) == \A x,y,z \in S : R[x,y] /\ R[y,z] => R[x,z]

(***************************************************************************)
(* Compute the transitive closure of relation R over set S.                *)
(*                                                                         *)
(* (See TransitiveClosure.tla of the TLA+ Example repository for           *)
(*  alternative definitions of the TransitiveClosure operator)             *)
(***************************************************************************)
TransitiveClosure(R, S) ==
  LET N == Cardinality(S)
      trcl[n \in Nat] == 
          [x,y \in S |-> IF n=0 THEN R[x,y]
                         ELSE \/ trcl[n-1][x,y]
                              \/ \E z \in S : trcl[n-1][x,z] /\ trcl[n-1][z,y]]
  IN  trcl[N]

(***************************************************************************)
(* Compute the reflexive transitive closure of relation R over set S.      *)
(***************************************************************************)
ReflexiveTransitiveClosure(R, S) ==
  LET trcl == TransitiveClosure(R,S)
  IN  [x,y \in S |-> x=y \/ trcl[x,y]]

=============================================================================
\* Modification History
\* Last modified Tue May 27 19:05:08 CEST 2020 by markus
\* Created Tue Apr 26 10:24:07 CEST 2016 by merz