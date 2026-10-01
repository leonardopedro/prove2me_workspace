-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.Comparison.selfAdjoint
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.QgOuterFockFL
open BookProof.QgOuterFockFL.Comparison



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

set_option maxHeartbeats 1000000 in
theorem solution (C : Comparison F) (w u : F)
    (hw : ∀ v : C.dom, (inner ℂ (C.op v) w : ℂ) = inner ℂ (v : F) u) :
    ∃ h : w ∈ C.dom, C.op ⟨w, h⟩ = u := by

  obtain ⟨x, hx⟩ := C.surj (u + w)
  have hperp : ∀ v : C.dom, (inner ℂ (C.op v + (v : F)) (w - (x : F)) : ℂ) = 0 := by
    intro v
    calc (inner ℂ (C.op v + (v : F)) (w - (x : F)) : ℂ)
        = ((inner ℂ (C.op v) w : ℂ) - inner ℂ (C.op v) (x : F))
            + ((inner ℂ (v : F) w : ℂ) - inner ℂ (v : F) (x : F)) := by
          rw [inner_add_left, inner_sub_right, inner_sub_right]
      _ = (inner ℂ (v : F) (u + w) : ℂ) - inner ℂ (v : F) (C.op x + (x : F)) := by
          rw [hw v, C.sym v x, inner_add_right, inner_add_right]
          ring
      _ = 0 := by rw [hx]; ring
  have hzero : w - (x : F) = 0 := by
    obtain ⟨y, hy⟩ := C.surj (w - (x : F))
    have hy0 := hperp y
    rw [hy] at hy0
    exact inner_self_eq_zero.mp hy0
  have hwx : w = (x : F) := sub_eq_zero.mp hzero
  refine ⟨hwx ▸ x.2, ?_⟩
  have hxe : (⟨w, hwx ▸ x.2⟩ : C.dom) = x := Subtype.ext hwx
  rw [hxe]
  have hfin : C.op x + (x : F) = u + (x : F) := by rw [hx, hwx]
  exact add_right_cancel hfin
