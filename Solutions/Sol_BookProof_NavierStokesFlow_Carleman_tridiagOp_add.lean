-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.tridiagOp_add
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (c c' : ℕ → ℂ) :
    tridiagOp c + tridiagOp c' = tridiagOp (fun n => c n + c' n) := by

  refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
  funext n
  cases n with
  | zero => simp only [LinearMap.add_apply, Submodule.coe_add, lp.coeFn_add, Pi.add_apply,
      tridiagOp_coe, tridiagFun]; ring
  | succ m => simp only [LinearMap.add_apply, Submodule.coe_add, lp.coeFn_add, Pi.add_apply,
      tridiagOp_coe, tridiagFun, map_add]; ring
