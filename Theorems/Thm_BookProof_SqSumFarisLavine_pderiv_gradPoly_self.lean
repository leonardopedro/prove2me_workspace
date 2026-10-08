-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.pderiv_gradPoly_self
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterGaussCoreQuadBounds
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.QgOuterFock
open BookProof.SqSumFarisLavine



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]


theorem BookProof.SqSumFarisLavine.pderiv_gradPoly_self (v : R → Fin D → ℝ) (k : Fin D) :
    pderiv k (gradPoly v k) = C (((∑ r : R, (v r k) ^ 2 : ℝ) : ℂ)) := by sorry
