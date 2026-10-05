-- Generated from ChapterYangMillsFieldStrength.lean — solution of BookProof.YangMillsFieldStrength.fieldStrengthMul_eq_Fbook
import Mathlib
import Definitions.Def_ChapterYangMillsFieldStrength
open BookProof.YangMillsFieldStrength



open Complex



variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]
variable {R : Type*} [Ring R] [Algebra ℂ R]

set_option maxHeartbeats 1000000 in
theorem solution
    (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R)
    (hsmul : ∀ (j : Fin 3) (c : ℂ) x, δ j (c • x) = c • δ j x) (j k : Fin 3) :
    fieldStrengthMul δ (fun j => (-(I * (g : ℂ))) • A j) j k
      = (-(I * (g : ℂ))) • Fbook δ g A j k := by

  simp only [fieldStrengthMul, Fbook]
  rw [hsmul, hsmul, smul_mul_smul_comm, smul_mul_smul_comm]
  module
