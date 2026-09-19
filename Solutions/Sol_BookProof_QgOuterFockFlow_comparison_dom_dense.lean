-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.comparison_dom_dense
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    [CompleteSpace F] (C : Comparison F) : Dense ((C.dom : Submodule ℂ F) : Set F) := by

  rw [Submodule.dense_iff_topologicalClosure_eq_top, Submodule.topologicalClosure_eq_top_iff,
    Submodule.eq_bot_iff]
  intro y hy
  obtain ⟨x, hx⟩ := C.surj y
  have hxy : (inner ℂ (x : F) y : ℂ) = 0 := (Submodule.mem_orthogonal _ _).mp hy x x.2
  rw [← hx] at hxy
  have hsplit : (inner ℂ (x : F) (C.op x + (x : F)) : ℂ)
      = (inner ℂ (x : F) (C.op x) : ℂ) + (inner ℂ (x : F) (x : F) : ℂ) := inner_add_right _ _ _
  have hre : quadForm C.op x + ‖(x : F)‖ ^ 2 = 0 := by
    have h := congrArg Complex.re (hsplit ▸ hxy)
    simpa [quadForm, inner_self_eq_norm_sq, Complex.add_re, ← Complex.ofReal_pow] using h
  have hpos := C.pos x
  have hx0 : (x : F) = 0 := by
    have hzero : ‖(x : F)‖ ^ 2 = 0 := by nlinarith [sq_nonneg ‖(x : F)‖]
    simpa using hzero
  have hxx : x = (0 : C.dom) := Subtype.ext (by simpa using hx0)
  have hy0 : y = 0 := by rw [← hx, hxx]; simp
  simpa using hy0
