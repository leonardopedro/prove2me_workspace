-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.weylEnergy_nonneg
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra

variable {L : Type*} [LieRing L]




open Finset


theorem BookProof.ChapterGaugeAdjointAlgebra.weylEnergy_nonneg {M : Type*} {κ : M → M → ℝ} (hpos : ∀ x : M, 0 ≤ κ x x)
    (π : Fin 3 → M) (B : Fin 3 → Fin 3 → M) :
    0 ≤ weylEnergy κ π B := by sorry
