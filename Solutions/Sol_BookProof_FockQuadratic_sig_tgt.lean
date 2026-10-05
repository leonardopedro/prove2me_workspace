-- Generated from ChapterFockQuadraticEsa.lean — solution of BookProof.FockQuadratic.sig_tgt
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Theorems.Thm_BookProof_FockQuadratic_wsum_add
import Theorems.Thm_BookProof_FockQuadratic_wsum_tsub_of_le
open BookProof.FockQuadratic



open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {ω : ι → ℝ} {P Q a : Idx ι} (h : P ≤ a) :
    sig ω (tgt P Q a) = sig ω a - wsum ω P - deg P + wsum ω Q + deg Q := by

  have hd : (deg (tgt P Q a) : ℝ) + deg P = deg a + deg Q := by
    exact_mod_cast congrArg (fun n : ℕ => (n : ℝ)) (deg_tgt (Q := Q) h)
  have hw : wsum ω (tgt P Q a) = wsum ω a - wsum ω P + wsum ω Q := by
    rw [tgt, wsum_add, ← wsum_tsub_of_le (ω := ω) h]
    ring
  simp only [sig, hw]
  linarith
