-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.qgOuterCore_le_friedDom
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_polyGaussCore_le_harmFriedDom
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
open BookProof.QgOuterFockFL



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

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable (C : ∀ i, Comparison (G i))
variable (H : ∀ i, (C i).dom →ₗ[ℂ] G i)
variable {C H}

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 1600000 in
-- the lifted domain is built from the Friedrichs completion, so unfolding it is costly
theorem solution : qgOuterCore ≤ qgOuterFriedDom := by

  intro x hx
  refine ⟨fun n => polyGaussCore_le_harmFriedDom (n * 84) (hx.2 n), ?_⟩
  have hfun : (fun n : ℕ => opTot (harmFried (n * 84)).op ((x : qgOuterFock) n))
      = fun n : ℕ => (harmCore ⟨(x : qgOuterFock) n, hx.2 n⟩ : L2d (n * 84)) := by
    funext n
    rw [opTot_of_mem _ (polyGaussCore_le_harmFriedDom (n * 84) (hx.2 n)),
      harmFried_op_core (n * 84) ⟨(x : qgOuterFock) n, hx.2 n⟩]
  rw [hfun]
  refine memLp_of_finite_support (Set.Finite.subset hx.1 fun n hn => ?_)
  simp only [Set.mem_setOf_eq] at hn ⊢
  intro h0
  refine hn ?_
  have hz : (⟨(x : qgOuterFock) n, hx.2 n⟩ : polyGaussCore (d := n * 84)) = 0 :=
    Subtype.ext h0
  rw [hz, map_zero]
