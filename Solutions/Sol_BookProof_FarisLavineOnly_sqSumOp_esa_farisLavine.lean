-- Generated from ChapterFarisLavineOnly.lean — solution of BookProof.FarisLavineOnly.sqSumOp_esa_farisLavine
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Theorems.Thm_BookProof_FarisLavineOnly_secHam_esa_fl
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterSqSumOuterFamily
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockCoreFL
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
open BookProof.HermiteProductCore
open BookProof.QgOuterFock

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (d : CoreData F)
variable {D : ℕ} {R : Type} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := D)) (sqSumOp kappa v) := secHam_esa_fl (constFamily kappa v) 0
