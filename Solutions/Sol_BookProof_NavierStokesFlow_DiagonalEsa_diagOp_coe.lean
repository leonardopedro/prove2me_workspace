-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.diagOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa










open scoped ENNReal











open LpNat





























open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℝ) (f : lpFiniteModes ℕ) :
    (((diagOp c f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = diagFun c ((f : L2N) : ℕ → ℂ) := rfl
