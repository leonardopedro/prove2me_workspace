-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.norm_nsCoupling_linear
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.norm_nsCoupling_linear (n : ℕ) :
    ‖nsCoupling (fun m : ℕ => (m : ℝ) + 1) n‖ = ((n : ℝ) + 3 / 2) := by sorry
