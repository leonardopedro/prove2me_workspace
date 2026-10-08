-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.conjP_volPot
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet



open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]


theorem BookProof.NsLagrangianDet.conjP_volPot (kappa : ℝ) (kv : K → Fin 3 → ℝ) :
    conjP (volPot kappa kv) = volPot kappa kv := by sorry
