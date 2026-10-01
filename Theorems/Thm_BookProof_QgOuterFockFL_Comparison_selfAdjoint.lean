-- Generated from ChapterQgOuterFockFarisLavine.lean — theorem BookProof.QgOuterFockFL.Comparison.selfAdjoint
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

theorem BookProof.QgOuterFockFL.Comparison.selfAdjoint (C : Comparison F) (w u : F)
    (hw : ∀ v : C.dom, (inner ℂ (C.op v) w : ℂ) = inner ℂ (v : F) u) :
    ∃ h : w ∈ C.dom, C.op ⟨w, h⟩ = u := by sorry
