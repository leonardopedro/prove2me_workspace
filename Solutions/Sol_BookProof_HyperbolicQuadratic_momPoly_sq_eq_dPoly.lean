import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.momPoly_sq_eq_dPoly
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_momPoly_apply'
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momPoly i (momPoly i p) = -(dPoly i (dPoly i p)) := by

  have h1 : momPoly i p = (-Complex.I) • dPoly i p := momPoly_apply' i p
  have h2 : momPoly i ((-Complex.I) • dPoly i p) = (-Complex.I) • momPoly i (dPoly i p) :=
    map_smul _ _ _
  have h3 : momPoly i (dPoly i p) = (-Complex.I) • dPoly i (dPoly i p) :=
    momPoly_apply' i (dPoly i p)
  have hII : (-Complex.I) * (-Complex.I) = (-1 : ℂ) := by simp [Complex.I_mul_I]
  rw [h1, h2, h3, smul_smul, hII, neg_smul, one_smul]
