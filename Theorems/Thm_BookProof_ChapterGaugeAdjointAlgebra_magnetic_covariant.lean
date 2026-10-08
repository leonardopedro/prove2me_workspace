-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.magnetic_covariant
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra




open Finset

variable {L : Type*} [LieRing L]


theorem BookProof.ChapterGaugeAdjointAlgebra.magnetic_covariant (A dθ : Fin 3 → L) (dA : Fin 3 → Fin 3 → L)
    (ddθ : Fin 3 → Fin 3 → L) (θ : L) (i j : Fin 3) (hsym : ddθ i j = ddθ j i) :
    ((ddθ i j + ⁅dA i j, θ⁆ + ⁅A j, dθ i⁆) - (ddθ j i + ⁅dA j i, θ⁆ + ⁅A i, dθ j⁆))
        + (⁅gaugeVarA A dθ θ i, A j⁆ + ⁅A i, gaugeVarA A dθ θ j⁆)
      = ⁅magnetic A dA i j, θ⁆ := by sorry
