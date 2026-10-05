-- Generated from ChapterFockQuadraticEsa.lean — solution of BookProof.FockQuadratic.wsum_single
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
open BookProof.FockQuadratic



open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable {ω : ι → ℝ}
variable {κ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (ω : ι → ℝ) (i : ι) (k : ℕ) : wsum ω (Finsupp.single i k) = ω i * k := by

  simp [wsum, Finsupp.sum_single_index]
