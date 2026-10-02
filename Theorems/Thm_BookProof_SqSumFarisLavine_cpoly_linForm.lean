-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.cpoly_linForm
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterGaussCoreQuadBounds
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.QgHermiteFriedrichs
open BookProof.QgOuterFock
open BookProof.SqSumFarisLavine




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section


theorem BookProof.SqSumFarisLavine.cpoly_linForm (v : Fin D → ℝ) : cpoly (linForm v) = linForm v := by sorry
