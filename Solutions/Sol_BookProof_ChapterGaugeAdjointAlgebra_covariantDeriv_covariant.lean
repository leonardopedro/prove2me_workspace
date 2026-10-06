-- Generated from ChapterGaugeAdjointAlgebra.lean — solution of BookProof.ChapterGaugeAdjointAlgebra.covariantDeriv_covariant
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
import Theorems.Thm_BookProof_ChapterGaugeAdjointAlgebra_lie_adj_leibniz
open BookProof.ChapterGaugeAdjointAlgebra





open Finset

variable {L : Type*} [LieRing L]

variable {L : Type*} [LieRing L]

set_option maxHeartbeats 1000000 in
theorem solution (A dX dθ : Fin 3 → L) (X θ : L) (i : Fin 3) :
    (⁅dX i, θ⁆ + ⁅X, dθ i⁆) + (⁅gaugeVarA A dθ θ i, X⁆ + ⁅A i, ⁅X, θ⁆⁆)
      = ⁅covariantDeriv A dX X i, θ⁆ := by

  have hc : ⁅X, dθ i⁆ = -⁅dθ i, X⁆ := (lie_skew X (dθ i)).symm
  simp only [covariantDeriv, gaugeVarA, add_lie]
  rw [← lie_adj_leibniz (A i) θ X, hc]
  abel
