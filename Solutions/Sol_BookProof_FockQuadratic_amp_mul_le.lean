-- Generated from ChapterFockQuadraticEsa.lean — solution of BookProof.FockQuadratic.amp_mul_le
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Theorems.Thm_BookProof_FockQuadratic_amp_le_sig
open BookProof.FockQuadratic



open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) {P Q : Idx ι} (hPQ : deg P + deg Q ≤ 2) (b : Idx ι)
    (p r : ℝ) :
    amp P Q b * r * p ≤ sig ω b * p ^ 2 + sig ω (tgt P Q b) * r ^ 2 := by

  have h1 : amp P Q b ≤ 2 * sig ω b := amp_le_sig hω hPQ
  have h2 : amp P Q b ≤ 2 * sig ω (tgt P Q b) := amp_le_sig_tgt hω hPQ
  have h0 : 0 ≤ amp P Q b := amp_nonneg _ _ _
  have hs1 : 0 ≤ sig ω b := sig_nonneg hω _
  have hs2 : 0 ≤ sig ω (tgt P Q b) := sig_nonneg hω _
  refine le_of_sq_le_sq ?_ (by positivity)
  have hamp : amp P Q b ^ 2 ≤ 4 * (sig ω b * sig ω (tgt P Q b)) := by nlinarith
  nlinarith [sq_nonneg (sig ω b * p ^ 2 - sig ω (tgt P Q b) * r ^ 2), sq_nonneg (p * r),
    sq_nonneg p, sq_nonneg r]
