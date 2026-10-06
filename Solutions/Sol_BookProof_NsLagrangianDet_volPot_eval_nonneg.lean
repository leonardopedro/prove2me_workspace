-- Generated from ChapterNsLagrangianDetConvolution.lean — solution of BookProof.NsLagrangianDet.volPot_eval_nonneg
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Theorems.Thm_BookProof_NsLagrangianDet_ev_volPot
open BookProof.NsLagrangianDet




open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]

set_option maxHeartbeats 1000000 in
theorem solution {kappa : ℝ} (hk : 0 ≤ kappa) (kv : K → Fin 3 → ℝ)
    (y : DIdx K → ℝ) : 0 ≤ (ev y (volPot kappa kv)).re := by

  rw [ev_volPot, Complex.ofReal_re]
  exact mul_nonneg (by linarith) (Finset.sum_nonneg fun q _ => Complex.normSq_nonneg _)
