-- Generated from ChapterFarisLavineOnly.lean — theorem BookProof.FarisLavineOnly.secHam_esa_fl
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.QgOuterFockCoreFL
open BookProof.FarisLavineOnly

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (d : CoreData F)


open scoped ENNReal

noncomputable section


open BookProof.FarisLavine











open Finset
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL BookProof.SqSumOuterFamily

theorem BookProof.FarisLavineOnly.secHam_esa_fl (F : SqFamily) (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := F.dim n)) (F.secHam n) := by sorry
