-- Generated from ChapterSqSumOuterSingleTime.lean — solution of BookProof.SqSumOuterFamily.SqFamily.truncHam_tendsto
import Mathlib
import Definitions.Def_ChapterSqSumOuterSingleTime
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_truncHam_eventuallyEq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSqSumOuterFamily
open BookProof.SqSumOuterFamily
open BookProof.SqSumOuterFamily.SqFamily




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.QgTimeIndependent BookProof.QgTruncationResolvent
open BookProof.DirectSumEsa BookProof.HermiteProductCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (F : SqFamily) (x : outerCore F.dim) :
    Tendsto (fun N : ℕ => (truncHam F N x : outerFock F.dim)) atTop (𝓝 (F.outerHam x)) := by

  refine Tendsto.congr' ?_ (tendsto_const_nhds (x := (F.outerHam x : outerFock F.dim)))
  filter_upwards [F.truncHam_eventuallyEq x] with N hN
  exact hN.symm
