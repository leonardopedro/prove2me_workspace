-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.weylEnergy_gauge_invariant
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra

variable {L : Type*} [LieRing L]




open Finset


theorem BookProof.ChapterGaugeAdjointAlgebra.weylEnergy_gauge_invariant {κ : L → L → ℝ}
    (hinv : ∀ x y z : L, κ ⁅x, z⁆ y + κ x ⁅y, z⁆ = 0)
    (hsymm : ∀ x y : L, κ x y = κ y x)
    (π : Fin 3 → L) (B : Fin 3 → Fin 3 → L) (θ : L) :
    (∑ i, κ ⁅π i, θ⁆ (π i)) + (1 / 2) * ∑ i, ∑ j, κ ⁅B i j, θ⁆ (B i j) = 0 := by sorry
