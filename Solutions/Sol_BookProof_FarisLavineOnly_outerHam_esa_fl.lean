-- Generated from ChapterFarisLavineOnly.lean — solution of BookProof.FarisLavineOnly.outerHam_esa_fl
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Theorems.Thm_BookProof_FarisLavineOnly_secHam_esa_fl
open BookProof.QgOuterFockCoreFL
open BookProof.FarisLavineOnly



open scoped ENNReal

noncomputable section


open BookProof.FarisLavine


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


variable (d : CoreData F)







open Finset
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL BookProof.SqSumOuterFamily

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (d : CoreData F)

set_option maxHeartbeats 1000000 in
theorem solution (F : SqFamily) :
    EssentiallySelfAdjointOn (outerCore F.dim) F.outerHam := dsOp_essentiallySelfAdjointOn _ fun n => secHam_esa_fl F n
