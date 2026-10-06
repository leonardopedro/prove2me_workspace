-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.covariantDeriv_covariant
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra

variable {L : Type*} [LieRing L]




open Finset


theorem BookProof.ChapterGaugeAdjointAlgebra.covariantDeriv_covariant (A dX dθ : Fin 3 → L) (X θ : L) (i : Fin 3) :
    (⁅dX i, θ⁆ + ⁅X, dθ i⁆) + (⁅gaugeVarA A dθ θ i, X⁆ + ⁅A i, ⁅X, θ⁆⁆)
      = ⁅covariantDeriv A dX X i, θ⁆ := by sorry
