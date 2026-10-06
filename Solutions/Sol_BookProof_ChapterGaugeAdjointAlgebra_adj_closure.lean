-- Generated from ChapterGaugeAdjointAlgebra.lean — solution of BookProof.ChapterGaugeAdjointAlgebra.adj_closure
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
import Theorems.Thm_BookProof_ChapterGaugeAdjointAlgebra_lie_adj_leibniz
open BookProof.ChapterGaugeAdjointAlgebra





open Finset

variable {L : Type*} [LieRing L]

variable {L : Type*} [LieRing L]

set_option maxHeartbeats 1000000 in
theorem solution (θ η X : L) :
    adjVar η (adjVar θ X) - adjVar θ (adjVar η X) = adjVar ⁅θ, η⁆ X := by

  simp only [adjVar_apply]
  rw [← lie_adj_leibniz X η θ, ← lie_skew θ η]
  simp
