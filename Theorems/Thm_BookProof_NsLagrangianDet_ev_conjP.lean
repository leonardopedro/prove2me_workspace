-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.ev_conjP
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet



open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]


theorem BookProof.NsLagrangianDet.ev_conjP (y : DIdx K → ℝ) (p : MvPolynomial (DIdx K) ℂ) :
    ev y (conjP p) = (starRingEnd ℂ) (ev y p) := by sorry
