-- Generated from ChapterQgOuterFockFarisLavine.lean — theorem BookProof.QgOuterFockFL.dsFibOp_hasSum_commForm
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

theorem BookProof.QgOuterFockFL.dsFibOp_hasSum_commForm {K : ℝ}
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (x : dsDom C) :
    HasSum (fun i => commForm (H i) (C i).op (fib C x i))
      (commForm (dsFibOp C H K hrel) (dsCompOp C) x) := by sorry
