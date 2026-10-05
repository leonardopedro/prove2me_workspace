-- Generated from ChapterYangMillsFieldStrength.lean — solution of BookProof.YangMillsFieldStrength.Fbook_antisymm
import Mathlib
import Definitions.Def_ChapterYangMillsFieldStrength
open BookProof.YangMillsFieldStrength



open Complex



variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]
variable {R : Type*} [Ring R] [Algebra ℂ R]

set_option maxHeartbeats 1000000 in
theorem solution (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R) (j k : Fin 3) :
    Fbook δ g A j k = - Fbook δ g A k j := by

  simp only [Fbook, smul_sub]; abel
