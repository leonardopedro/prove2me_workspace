-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.DiagonalEsa.diagOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa









open scoped ENNReal











open LpNat





























open LpNat

theorem BookProof.NavierStokesFlow.DiagonalEsa.diagOp_coe (c : ℕ → ℝ) (f : lpFiniteModes ℕ) :
    (((diagOp c f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = diagFun c ((f : L2N) : ℕ → ℂ) := by sorry
