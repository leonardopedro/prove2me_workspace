-- Generated from ChapterFockQuadraticEsa.lean — solution of BookProof.FockQuadratic.amp_le_sig
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
open BookProof.FockQuadratic



open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i) {P Q a : Idx ι} (hPQ : deg P + deg Q ≤ 2) :
    amp P Q a ≤ 2 * sig ω a := le_trans (amp_le_deg_add_two hPQ) (deg_add_two_le_sig hω a)
