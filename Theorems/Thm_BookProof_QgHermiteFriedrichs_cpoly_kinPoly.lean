-- Generated from ChapterQgHermiteFriedrichs.lean — theorem BookProof.QgHermiteFriedrichs.cpoly_kinPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.QgHermiteFriedrichs



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.Starobinsky
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension

noncomputable section

variable {d : ℕ}


theorem BookProof.QgHermiteFriedrichs.cpoly_kinPoly (p : MvPolynomial (Fin d) ℂ) :
    cpoly (kinPoly p) = kinPoly (cpoly p) := by sorry
