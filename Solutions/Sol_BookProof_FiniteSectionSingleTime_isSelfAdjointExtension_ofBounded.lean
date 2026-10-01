-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.isSelfAdjointExtension_ofBounded
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
open BookProof.FiniteSectionSingleTime



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    (D : Submodule ℂ F) :
    IsSelfAdjointExtension ((A : F →ₗ[ℂ] F).comp D.subtype) (ofBounded A hA).op := by

  have hsymm := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hA
  refine ⟨fun x => ⟨Submodule.mem_top, rfl⟩, fun x y => hsymm _ _, ?_⟩
  intro w u hwu
  refine ⟨Submodule.mem_top, ?_⟩
  have hall : ∀ v : F, (inner ℂ v (A w) : ℂ) = inner ℂ v u := by
    intro v
    have h : (inner ℂ (A v) w : ℂ) = inner ℂ v u := hwu ⟨v, Submodule.mem_top⟩
    rw [← h]
    exact (hsymm v w).symm
  have hzero : ∀ v : F, (inner ℂ v (A w - u) : ℂ) = 0 := by
    intro v; rw [inner_sub_right, hall v]; ring
  have hsub : A w - u = 0 := by
    have h0 := hzero (A w - u)
    simpa using inner_self_eq_zero.mp h0
  exact sub_eq_zero.mp hsub
