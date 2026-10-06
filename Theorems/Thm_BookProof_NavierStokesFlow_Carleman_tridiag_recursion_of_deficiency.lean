-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.tridiag_recursion_of_deficiency
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

theorem BookProof.NavierStokesFlow.Carleman.tridiag_recursion_of_deficiency (c : ℕ → ℂ) (z : ℂ) (w : L2N)
    (hw : ∀ v : lpFiniteModes ℕ,
      (inner ℂ ((tridiagOp c v : lpFiniteModes ℕ) : L2N) w : ℂ)
        = inner ℂ ((v : lpFiniteModes ℕ) : L2N) (z • w)) :
    ∀ n, tridiagFun c ((w : L2N) : ℕ → ℂ) n = z * ((w : L2N) : ℕ → ℂ) n := by sorry
