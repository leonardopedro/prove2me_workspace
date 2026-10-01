-- Generated from ChapterQgOuterFockFarisLavine.lean — theorem BookProof.QgOuterFockFL.qgOuterFriedN_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.QgOuterFockFL

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable (C : ∀ i, Comparison (G i))
variable (H : ∀ i, (C i).dom →ₗ[ℂ] G i)
variable {C H}


open scoped ENNReal


open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HashimotoShiftInvert
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 2000000 in
-- the Friedrichs domain is a range of a completion-built resolvent: defeq checks are costly
theorem BookProof.QgOuterFockFL.qgOuterFriedN_isPositiveSelfAdjointExtension :
    IsPositiveSelfAdjointExtension qgOuterN qgOuterFriedN := by sorry
