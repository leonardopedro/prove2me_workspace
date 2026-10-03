-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.summable_normSq
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.summable_normSq (f : L2N) : Summable fun n : ℕ => ‖(f : ℕ → ℂ) n‖ ^ 2 := by sorry
