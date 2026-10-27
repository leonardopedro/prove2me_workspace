-- Generated from ChapterSqSumOuterSingleTime.lean — solution of BookProof.SqSumOuterFamily.SqFamily.truncHam_eventuallyEq
import Mathlib
import Definitions.Def_ChapterSqSumOuterSingleTime
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_truncHam_eq_of_support
open BookProof.SqSumOuterFamily
open BookProof.SqSumOuterFamily.SqFamily




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.QgTimeIndependent BookProof.QgTruncationResolvent
open BookProof.DirectSumEsa BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (F : SqFamily) (x : outerCore F.dim) :
    ∀ᶠ N in atTop, (truncHam F N x : outerFock F.dim) = F.outerHam x := by

  obtain ⟨N₀, hN₀⟩ : ∃ N₀ : ℕ, ∀ n : ℕ,
      ((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n ≠ 0 → n ≤ N₀ := by
    obtain ⟨N₀, hN₀⟩ := x.2.1.bddAbove
    exact ⟨N₀, fun n hn => hN₀ hn⟩
  filter_upwards [eventually_ge_atTop N₀] with N hN
  refine truncHam_eq_of_support F x fun n hn => ?_
  by_contra hne
  exact absurd (hN₀ n hne) (by omega)
