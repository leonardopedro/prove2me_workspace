-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.kin_mul_comm
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterGaussCoreQuadBounds
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.QgHermiteFriedrichs
open BookProof.SqSumFarisLavine



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]


theorem BookProof.SqSumFarisLavine.kin_mul_comm (c : Fin D → ℂ) (f p : MvPolynomial (Fin D) ℂ) :
    (∑ j : Fin D, c j • coreD j (coreD j (f * p))) - f * ∑ j : Fin D, c j • coreD j (coreD j p)
      = ∑ j : Fin D, c j • (pderiv j (pderiv j f) * p
          + (2 : ℂ) • (pderiv j f * coreD j p)) := by sorry
