-- Generated from ChapterSqSumOuterSingleTime.lean — solution of BookProof.SqSumOuterFamily.SqFamily.trunc_secHam_eq_of_le
import Mathlib
import Definitions.Def_ChapterSqSumOuterSingleTime
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
theorem solution (F : SqFamily) {N n : ℕ} (h : n ≤ N) :
    (F.trunc N).secHam n = F.secHam n := by

  have hvv : (F.trunc N).vv n = F.vv n := by
    funext r I
    simp [trunc, h]
  rw [secHam, secHam, hvv]
  rfl
