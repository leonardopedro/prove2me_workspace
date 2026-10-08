-- Generated from ChapterQgHermiteFriedrichs.lean — theorem BookProof.QgHermiteFriedrichs.hasDerivAt_gaussD_coordLine
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.Starobinsky
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension

noncomputable section

variable {d : ℕ}

variable (W : Vd d → ℝ)

theorem BookProof.QgHermiteFriedrichs.hasDerivAt_gaussD_coordLine (x : Vd d) (j : Fin d) (t : ℝ) :
    HasDerivAt (fun s : ℝ => gaussD (coordLine x j s))
      (-(t / 2) * gaussD (coordLine x j t)) t := by sorry
