-- Generated from ChapterFarisLavineOnly.lean — solution of BookProof.FarisLavineOnly.secHam_esa_fl
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_esa_on_core
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_flc_nonneg
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secData_commForm_le
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secHam_symmetricOn
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
theorem solution (F : SqFamily) (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := F.dim n)) (F.secHam n) := (F.secData n).esa_on_core (F.secHam_symmetricOn n) F.flc_nonneg (F.secData_commForm_le n)
