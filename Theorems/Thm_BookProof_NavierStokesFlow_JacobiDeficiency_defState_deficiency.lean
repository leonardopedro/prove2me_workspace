-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.JacobiDeficiency.defState_deficiency
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency









open scoped ENNReal











open LpNat

theorem BookProof.NavierStokesFlow.JacobiDeficiency.defState_deficiency (v : lpFiniteModes ℕ) :
    (inner ℂ ((jacobiOp v : lpFiniteModes ℕ) : L2N) defState : ℂ)
      = inner ℂ ((v : lpFiniteModes ℕ) : L2N) (Complex.I • defState) := by sorry
