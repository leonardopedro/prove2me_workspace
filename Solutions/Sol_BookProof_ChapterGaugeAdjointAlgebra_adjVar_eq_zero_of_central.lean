-- Generated from ChapterGaugeAdjointAlgebra.lean — solution of BookProof.ChapterGaugeAdjointAlgebra.adjVar_eq_zero_of_central
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra





open Finset

variable {L : Type*} [LieRing L]

variable {L : Type*} [LieRing L]

set_option maxHeartbeats 1000000 in
theorem solution {X : L} (hX : ∀ θ : L, ⁅X, θ⁆ = 0) (θ : L) :
    adjVar θ X = 0 := hX θ
