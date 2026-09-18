import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterNavierStokesThreeComponent
-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.comm_momPoly_mulXPoly
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momPoly i (mulXPoly k p) - mulXPoly k (momPoly i p)
      = C (if i = k then -Complex.I else 0) * p := by

  classical
  have hpd : pderiv i (X k * p) = (if i = k then (1 : MvPolynomial (Fin d) ℂ) else 0) * p
      + X k * pderiv i p := by
    rw [Derivation.leibniz]
    by_cases hik : i = k
    · subst hik
      rw [if_pos rfl, pderiv_X_self]
      simp only [smul_eq_mul, mul_one, one_mul]
      ring
    · rw [pderiv_X_of_ne (Ne.symm hik), if_neg hik]
      simp [smul_eq_mul]
  simp only [momPoly_apply, mulXPoly_apply, hpd]
  by_cases hik : i = k
  · subst hik
    rw [if_pos rfl, if_pos rfl]
    ring
  · rw [if_neg hik, if_neg hik]
    simp only [map_zero, zero_mul]
    ring
