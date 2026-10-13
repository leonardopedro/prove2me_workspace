-- Generated from ChapterSqSumOuterSingleTime.lean — solution of BookProof.SqSumOuterFamily.SqFamily.truncHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterSqSumOuterSingleTime
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_symmetricOn
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secHam_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
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
theorem solution (F : SqFamily) (N : ℕ) :
    SymmetricOn (outerCore F.dim) (truncHam F N) := dsOp_symmetricOn _ fun n => (F.trunc N).secHam_symmetricOn n
