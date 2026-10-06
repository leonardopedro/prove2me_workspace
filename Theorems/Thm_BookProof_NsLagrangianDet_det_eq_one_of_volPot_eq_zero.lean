-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.det_eq_one_of_volPot_eq_zero
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet

variable {K : Type*} [Fintype K]



open MvPolynomial Matrix

noncomputable section


theorem BookProof.NsLagrangianDet.det_eq_one_of_volPot_eq_zero {kappa : ℝ} (hk : 0 < kappa) (kv : K → Fin 3 → ℝ)
    (y : DIdx K → ℝ) (h : ev y (volPot kappa kv) = 0) (a : Fin 3 → ℝ) :
    (1 + dispGrad kv y a).det = 1 := by sorry
