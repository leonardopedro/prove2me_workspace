-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.volPot_eval_nonneg
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet



open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]


theorem BookProof.NsLagrangianDet.volPot_eval_nonneg {kappa : ℝ} (hk : 0 ≤ kappa) (kv : K → Fin 3 → ℝ)
    (y : DIdx K → ℝ) : 0 ≤ (ev y (volPot kappa kv)).re := by sorry
