-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.det_rows_sum
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet

variable {K : Type*} [Fintype K]



open MvPolynomial Matrix

noncomputable section


theorem BookProof.NsLagrangianDet.det_rows_sum {n ι R : Type*} [Fintype n] [DecidableEq n] [Fintype ι] [CommRing R]
    (v : n → ι → n → R) :
    (Matrix.of fun r c => ∑ o, v r o c).det
      = ∑ τ : n → ι, (Matrix.of fun r c => v r (τ r) c).det := by sorry
