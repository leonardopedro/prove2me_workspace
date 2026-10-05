-- Generated from ChapterSqSumOuterSingleTime.lean — theorem BookProof.SqSumOuterFamily.SqFamily.truncHam_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterSqSumOuterSingleTime
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSqSumOuterFamily
open BookProof.HermiteProductCore
open BookProof.SqSumOuterFamily



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.QgTimeIndependent BookProof.QgTruncationResolvent
open BookProof.DirectSumEsa BookProof.HermiteProductCore

noncomputable section

theorem BookProof.SqSumOuterFamily.SqFamily.truncHam_symmetricOn (F : SqFamily) (N : ℕ) :
    SymmetricOn (outerCore F.dim) (truncHam F N) := by sorry
