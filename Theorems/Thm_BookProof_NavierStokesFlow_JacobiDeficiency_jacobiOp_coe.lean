-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.JacobiDeficiency.jacobiOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency









open scoped ENNReal











open LpNat

theorem BookProof.NavierStokesFlow.JacobiDeficiency.jacobiOp_coe (f : lpFiniteModes ℕ) :
    (((jacobiOp f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = jacobiFun ((f : L2N) : ℕ → ℂ) := by sorry
