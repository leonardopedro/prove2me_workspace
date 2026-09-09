-- Generated from ChapterYangMillsBianchi.lean — solution of BookProof.YangMillsBianchi.bianchi
import Mathlib
import Mathlib.Tactic.NoncommRing
import Definitions.Def_ChapterYangMillsBianchi
open BookProof.YangMillsBianchi










open BigOperators



variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (D : Fin 3 → R) :
    ∑ i, ∑ j, ∑ k, (eps i j k) • ⁅D i, ⁅D j, D k⁆⁆ = 0 := by

  simp [ Fin.sum_univ_three, eps ];
  simp [ Int.sign ];
  simp only [Bracket.bracket]
  noncomm_ring
