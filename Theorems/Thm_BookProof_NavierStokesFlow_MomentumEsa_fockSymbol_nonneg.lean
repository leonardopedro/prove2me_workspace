-- Generated from ChapterNavierStokesMomentumEsa.lean — theorem BookProof.NavierStokesFlow.MomentumEsa.fockSymbol_nonneg
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa

variable {ι : Type*}




open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

theorem BookProof.NavierStokesFlow.MomentumEsa.fockSymbol_nonneg (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k) (a : Config) :
    0 ≤ fockSymbol n a := by sorry
