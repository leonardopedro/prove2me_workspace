-- Generated from ChapterFockQuadraticEsa.lean — solution of BookProof.FockQuadratic.wsum_tsub_of_le
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Theorems.Thm_BookProof_FockQuadratic_wsum_add
import Theorems.Thm_BookProof_CarlemanSimplex_tsub_add_cancel_of_le_prime
open BookProof.FockQuadratic



open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {ω : ι → ℝ} {P a : Idx ι} (h : P ≤ a) :
    wsum ω (a - P) + wsum ω P = wsum ω a := by

  rw [← wsum_add, tsub_add_cancel_of_le' h]
