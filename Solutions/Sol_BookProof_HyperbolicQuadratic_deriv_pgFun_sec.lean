import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.deriv_pgFun_sec
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_sec_sec
import Theorems.Thm_BookProof_HyperbolicQuadratic_sec_coord
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) (t : ℝ) :
    deriv (fun s : ℝ => pgFun p (sec i x s)) t = pgFun (dPoly i p) (sec i x t) := by

  have h := hasDerivAt_pgFun_sec i p (sec i x t)
  rw [sec_coord] at h
  simp only [sec_sec] at h
  exact h.deriv
