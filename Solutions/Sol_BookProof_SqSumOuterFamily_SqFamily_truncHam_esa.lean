-- Generated from ChapterSqSumOuterSingleTime.lean — solution of BookProof.SqSumOuterFamily.SqFamily.truncHam_esa
import Mathlib
import Definitions.Def_ChapterSqSumOuterSingleTime
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secHam_essentiallySelfAdjointOn
open BookProof.SqSumOuterFamily




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.QgTimeIndependent BookProof.QgTruncationResolvent
open BookProof.DirectSumEsa BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (F : SqFamily) (N : ℕ) :
    EssentiallySelfAdjointOn (outerCore F.dim) (truncHam F N) := dsOp_essentiallySelfAdjointOn _ fun n => (F.trunc N).secHam_essentiallySelfAdjointOn n
