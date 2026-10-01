-- Generated from ChapterQgHermiteFriedrichs.lean — theorem BookProof.QgHermiteFriedrichs.hasDerivAt_polyEval_coordLine
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

variable {d : ℕ}
variable (W : Vd d → ℝ)



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.Starobinsky
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension

noncomputable section

variable {d : ℕ}

theorem BookProof.QgHermiteFriedrichs.hasDerivAt_polyEval_coordLine (p : MvPolynomial (Fin d) ℂ) (x : Vd d) (j : Fin d)
    (t : ℝ) :
    HasDerivAt (fun s : ℝ => MvPolynomial.eval (fun i => (((coordLine x j s) i : ℝ) : ℂ)) p)
      (MvPolynomial.eval (fun i => (((coordLine x j t) i : ℝ) : ℂ)) (pderiv j p)) t := by sorry
