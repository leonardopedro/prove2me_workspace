import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.hermiteMvLp_total
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvBasis_apply
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (w : L2d d) (h : ∀ a, (inner ℂ (hermiteMvLp a) w : ℂ) = 0) :
    w = 0 := by

  have hrepr : (hermiteMvBasis (d := d)).repr w = 0 := by
    ext a
    rw [HilbertBasis.repr_apply_apply, hermiteMvBasis_apply, h a]
    simp
  simpa using congrArg (hermiteMvBasis (d := d)).repr.symm hrepr
