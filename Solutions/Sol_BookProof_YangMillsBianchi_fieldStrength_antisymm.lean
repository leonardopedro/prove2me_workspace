-- Generated from ChapterYangMillsBianchi.lean — solution of BookProof.YangMillsBianchi.fieldStrength_antisymm
import Mathlib
import Definitions.Def_ChapterYangMillsBianchi
open BookProof.YangMillsBianchi










open BigOperators



variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (D : Fin 3 → R) (j k : Fin 3) :
    fieldStrength D j k = - fieldStrength D k j := by

  simp only [fieldStrength]
  exact (lie_skew (D j) (D k)).symm
