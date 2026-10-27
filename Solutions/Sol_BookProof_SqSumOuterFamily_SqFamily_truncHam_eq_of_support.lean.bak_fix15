-- Generated from ChapterSqSumOuterSingleTime.lean — solution of BookProof.SqSumOuterFamily.SqFamily.truncHam_eq_of_support
import Mathlib
import Definitions.Def_ChapterSqSumOuterSingleTime
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_trunc_secHam_eq_of_le
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
theorem solution (F : SqFamily) (x : outerCore F.dim) {N : ℕ}
    (hsupp : ∀ n : ℕ, N < n → ((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n = 0) :
    (truncHam F N x : outerFock F.dim) = F.outerHam x := by

  refine lp.ext (funext fun n => ?_)
  have h2 : ((F.outerHam x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n
      = F.secHam n
          ((⟨((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n, x.2.2 n⟩ :
            ↥(polyGaussCore (d := F.dim n))) : polyGaussCore (d := F.dim n)) := rfl
  by_cases h : n ≤ N
  · rw [truncHam_coe, h2, trunc_secHam_eq_of_le F h]
    rfl
  · have hzero : (⟨((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n, x.2.2 n⟩ :
        ↥(polyGaussCore (d := F.dim n))) = 0 :=
      Subtype.ext (hsupp n (by omega))
    rw [truncHam_coe, h2]
    simp only [hzero, LinearMap.map_zero]
    exact LinearMap.map_zero ((F.trunc N).secHam n)
