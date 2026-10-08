-- Generated from ChapterYangMillsFieldStrength.lean — theorem BookProof.YangMillsFieldStrength.fieldStrengthMul_eq_Fbook
import Mathlib
import Definitions.Def_ChapterYangMillsFieldStrength
open BookProof.YangMillsFieldStrength


open Complex



variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R] [Algebra ℂ R]

theorem BookProof.YangMillsFieldStrength.fieldStrengthMul_eq_Fbook
    (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R)
    (hsmul : ∀ (j : Fin 3) (c : ℂ) x, δ j (c • x) = c • δ j x) (j k : Fin 3) :
    fieldStrengthMul δ (fun j => (-(I * (g : ℂ))) • A j) j k
      = (-(I * (g : ℂ))) • Fbook δ g A j k := by sorry
