-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.momOp_apply_eq_differential
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_hasDerivAt_pgFun_sec
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
wise. -/
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (mulXPoly i p) x = ((x i : ℝ) : ℂ) * pgFun p x := by
  simp [pgFun, mulXPoly]
  ring

/-- **The momentum operator is the derivative**: at every point, the value of `momOp i` on
`f = p·e^{-‖u‖²/4}` is `−i` times the honest derivative of `f` along the `i`-th
coordinate. :=
   -/
  theorem momOp_apply_eq_differential (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
      pgFun (momPoly i p) x
        = -Complex.I * deriv (fun t : ℝ => pgFun p (sec i x t)) (x i) := by
    rw [
