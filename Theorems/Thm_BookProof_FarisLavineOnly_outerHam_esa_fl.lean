-- Generated from ChapterFarisLavineOnly.lean — theorem BookProof.FarisLavineOnly.outerHam_esa_fl
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterSqSumOuterFamily
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.HermiteProductCore
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


theorem BookProof.FarisLavineOnly.outerHam_esa_fl (F : SqFamily) :
    EssentiallySelfAdjointOn (outerCore F.dim) F.outerHam := by sorry
