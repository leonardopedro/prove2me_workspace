-- Generated from ChapterSqSumOuterFamily.lean — theorem BookProof.SqSumOuterFamily.SqFamily.secHam_commForm_le
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterGaussCoreQuadBounds
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterMajoranaClifford
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.HermiteProductCore
open BookProof.MajoranaClifford
open BookProof.QgHermiteOscillator
open BookProof.QgOuterFock
open BookProof.SqSumFarisLavine
open BookProof.SqSumOuterFamily
open BookProof.SqSumOuterFamily.SqFamily

variable (dim : ℕ → ℕ)
variable (F : SqFamily)



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

theorem BookProof.SqSumOuterFamily.SqFamily.secHam_commForm_le (n : ℕ) (u : polyGaussCore (d := F.dim n)) :
    |commForm (F.secHam n) harmCore u| ≤ F.flc * quadForm harmCore u := by sorry
