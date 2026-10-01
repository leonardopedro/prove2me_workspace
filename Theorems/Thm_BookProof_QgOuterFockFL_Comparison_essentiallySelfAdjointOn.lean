-- Generated from ChapterQgOuterFockFarisLavine.lean — theorem BookProof.QgOuterFockFL.Comparison.essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.QgOuterFockFL
open BookProof.QgOuterFockFL.Comparison

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

theorem BookProof.QgOuterFockFL.Comparison.essentiallySelfAdjointOn [CompleteSpace F] (C : Comparison F)
    (H : C.dom →ₗ[ℂ] F) (hH : SymmetricOn C.dom H) (c : ℝ) (hc : 0 ≤ c)
    (hcomm : ∀ x : C.dom, |commForm H C.op x| ≤ c * quadForm C.op x) :
    EssentiallySelfAdjointOn C.dom H := by sorry
