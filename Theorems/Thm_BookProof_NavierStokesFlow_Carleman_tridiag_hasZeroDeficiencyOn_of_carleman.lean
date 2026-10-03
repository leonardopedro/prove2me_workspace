-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.tridiag_hasZeroDeficiencyOn_of_carleman
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.tridiag_hasZeroDeficiencyOn_of_carleman (c : ℕ → ℂ)
    (hcar : ¬ Summable fun n => 1 / ‖c n‖) :
    HasZeroDeficiencyOn (lpFiniteModes ℕ) (tridiagOp c) := by sorry
