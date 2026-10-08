-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.inner_adjVar_self_eq_zero
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra




open Finset

variable {L : Type*} [LieRing L]


theorem BookProof.ChapterGaugeAdjointAlgebra.inner_adjVar_self_eq_zero {κ : L → L → ℝ}
    (hinv : ∀ x y z : L, κ ⁅x, z⁆ y + κ x ⁅y, z⁆ = 0)
    (hsymm : ∀ x y : L, κ x y = κ y x) (x θ : L) : κ ⁅x, θ⁆ x = 0 := by sorry
