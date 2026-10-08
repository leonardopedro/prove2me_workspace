-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.gaussLaw_constraint_surface_invariant
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra




open Finset

variable {L : Type*} [LieRing L]


theorem BookProof.ChapterGaugeAdjointAlgebra.gaussLaw_constraint_surface_invariant (A dπ π : Fin 3 → L) (θ : L)
    (hG : gaussLaw A dπ π = 0) :
    ∑ i, (⁅dπ i, θ⁆ + (⁅⁅A i, θ⁆, π i⁆ + ⁅A i, ⁅π i, θ⁆⁆)) = 0 := by sorry
