-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.gaussLaw_covariant
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra

variable {L : Type*} [LieRing L]




open Finset


theorem BookProof.ChapterGaugeAdjointAlgebra.gaussLaw_covariant (A dπ π : Fin 3 → L) (θ : L) :
    ∑ i, (⁅dπ i, θ⁆ + (⁅⁅A i, θ⁆, π i⁆ + ⁅A i, ⁅π i, θ⁆⁆))
      = ⁅gaussLaw A dπ π, θ⁆ := by sorry
