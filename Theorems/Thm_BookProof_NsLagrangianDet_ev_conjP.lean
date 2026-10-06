-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.ev_conjP
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet

variable {K : Type*} [Fintype K]



open MvPolynomial Matrix

noncomputable section


theorem BookProof.NsLagrangianDet.ev_conjP (y : DIdx K → ℝ) (p : MvPolynomial (DIdx K) ℂ) :
    ev y (conjP p) = (starRingEnd ℂ) (ev y p) := by sorry
