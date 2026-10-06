-- Generated from ChapterGaugeAdjointAlgebra.lean — solution of BookProof.ChapterGaugeAdjointAlgebra.lie_adj_leibniz
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra





open Finset

variable {L : Type*} [LieRing L]

variable {L : Type*} [LieRing L]

set_option maxHeartbeats 1000000 in
theorem solution (x θ y : L) : ⁅⁅x, θ⁆, y⁆ + ⁅x, ⁅y, θ⁆⁆ = ⁅⁅x, y⁆, θ⁆ := by

  rw [lie_lie x y θ, ← lie_skew ⁅x, θ⁆ y]
  abel
