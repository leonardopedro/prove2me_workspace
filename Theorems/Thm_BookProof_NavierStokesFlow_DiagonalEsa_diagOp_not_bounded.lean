-- Generated from ChapterNavierStokesDeficiency.lean — theorem BookProof.NavierStokesFlow.DiagonalEsa.diagOp_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa


open scoped ENNReal

theorem BookProof.NavierStokesFlow.DiagonalEsa.diagOp_not_bounded (c : ℕ → ℝ) (hc : ∀ C : ℝ, ∃ n, C < |c n|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ℕ, ‖diagOp c f‖ ≤ C * ‖f‖ := by sorry
