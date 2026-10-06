-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.tridiagOp_basis_succ
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.tridiagOp_basis_succ (c : ℕ → ℂ) (k : ℕ) :
    ((tridiagOp c (basis (k + 1)) : lpFiniteModes ℕ) : L2N)
      = (starRingEnd ℂ (c (k + 1))) • lp.single 2 (k + 2) (1 : ℂ)
        + (c k) • lp.single 2 k (1 : ℂ) := by sorry
