-- Generated from ChapterNavierStokesCarleman.lean — theorem BookProof.NavierStokesFlow.Carleman.tridiagOp_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow


open scoped ENNReal



open LpNat DiagonalEsa FullEsa

theorem BookProof.NavierStokesFlow.Carleman.tridiagOp_not_bounded (c : ℕ → ℂ) (hc : ∀ C : ℝ, ∃ n, C < ‖c n‖) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ℕ, ‖tridiagOp c f‖ ≤ C * ‖f‖ := by sorry
