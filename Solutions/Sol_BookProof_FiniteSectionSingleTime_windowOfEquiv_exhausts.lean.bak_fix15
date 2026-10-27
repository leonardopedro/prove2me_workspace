-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.windowOfEquiv_exhausts
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

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)

set_option maxHeartbeats 1000000 in
theorem solution (en : ℕ ≃ ι) : Exhausts (windowOfEquiv en) := by

  classical
  intro F
  obtain ⟨N, hN⟩ : ∃ N : ℕ, ∀ k ∈ F, en.symm k < N := by
    refine ⟨(F.image en.symm).sup id + 1, fun k hk => ?_⟩
    have : en.symm k ≤ (F.image en.symm).sup id :=
      Finset.le_sup (f := id) (Finset.mem_image_of_mem _ hk)
    omega
  filter_upwards [eventually_ge_atTop N] with n hn
  intro k hk
  refine Finset.mem_image.mpr ⟨en.symm k, ?_, by simp⟩
  exact Finset.mem_range.mpr (lt_of_lt_of_le (hN k hk) hn)
