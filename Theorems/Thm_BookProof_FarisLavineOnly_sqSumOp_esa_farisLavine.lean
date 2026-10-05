-- Generated from ChapterFarisLavineOnly.lean — theorem BookProof.FarisLavineOnly.sqSumOp_esa_farisLavine
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterSqSumOuterFamily
import Mathlib
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.HermiteProductCore
open BookProof.QgOuterFock
open BookProof.QgOuterFockCoreFL
open BookProof.FarisLavineOnly

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (d : CoreData F)
variable {D : ℕ} {R : Type} [Fintype R]


open scoped ENNReal

noncomputable section


open BookProof.FarisLavine











open Finset
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL BookProof.SqSumOuterFamily

theorem BookProof.FarisLavineOnly.sqSumOp_esa_farisLavine (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := D)) (sqSumOp kappa v) := by sorry
