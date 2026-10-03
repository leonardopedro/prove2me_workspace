-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.tridiagOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.tridiagOp_coe (c : ℕ → ℂ) (f : lpFiniteModes ℕ) :
    (((tridiagOp c f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = tridiagFun c ((f : L2N) : ℕ → ℂ) := by sorry
