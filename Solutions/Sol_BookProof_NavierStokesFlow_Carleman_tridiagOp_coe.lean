-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.tridiagOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℂ) (f : lpFiniteModes ℕ) :
    (((tridiagOp c f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = tridiagFun c ((f : L2N) : ℕ → ℂ) := rfl
