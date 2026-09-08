-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobiOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (f : lpFiniteModes ℕ) :
    (((jacobiOp f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = jacobiFun ((f : L2N) : ℕ → ℂ) := rfl
