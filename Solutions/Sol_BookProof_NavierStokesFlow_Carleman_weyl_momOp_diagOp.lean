-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.weyl_momOp_diagOp
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (a : ℕ → ℝ) :
    momOp.comp (diagOp a) + (diagOp a).comp momOp = tridiagOp (nsCoupling a) := by

  refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
  funext n
  cases n with
  | zero =>
      simp only [LinearMap.add_apply, LinearMap.comp_apply, Submodule.coe_add, lp.coeFn_add,
        Pi.add_apply, momOp, tridiagOp_coe, diagOp_coe, tridiagFun, diagFun, nsCoupling]
      ring
  | succ m =>
      simp only [LinearMap.add_apply, LinearMap.comp_apply, Submodule.coe_add, lp.coeFn_add,
        Pi.add_apply, momOp, tridiagOp_coe, diagOp_coe, tridiagFun, diagFun, nsCoupling,
        map_mul, map_neg, map_div₀, Complex.conj_I, Complex.conj_ofNat, Complex.conj_ofReal,
        map_add]
      ring
