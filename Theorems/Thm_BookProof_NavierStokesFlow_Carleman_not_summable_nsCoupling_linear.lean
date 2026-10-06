-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.not_summable_nsCoupling_linear
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.not_summable_nsCoupling_linear :
    ¬ Summable fun n : ℕ => 1 / ‖nsCoupling (fun m : ℕ => (m : ℝ) + 1) n‖ := by sorry
