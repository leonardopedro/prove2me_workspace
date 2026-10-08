-- Generated from ChapterNavierStokesMomentumEsa.lean — theorem BookProof.NavierStokesFlow.MomentumEsa.fockComparison_quadForm_ge
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa




open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

theorem BookProof.NavierStokesFlow.MomentumEsa.fockComparison_quadForm_ge (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k)
    (x : maxDom (fockSymbol n)) :
    ‖(x : L2I Config)‖ ^ 2 ≤ quadForm (diagMax (fockSymbol n)) x := by sorry
