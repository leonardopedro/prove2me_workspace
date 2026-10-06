-- Generated from ChapterNavierStokesMomentumEsa.lean — theorem BookProof.NavierStokesFlow.MomentumEsa.fockComparison_add_one_surjective
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa

variable {ι : Type*}




open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

theorem BookProof.NavierStokesFlow.MomentumEsa.fockComparison_add_one_surjective (n : ℕ → ℝ) (hn : ∀ k, 0 ≤ n k) (f : L2I Config) :
    ∃ x : maxDom (fockSymbol n), (diagMax (fockSymbol n) x : L2I Config) + (x : L2I Config) = f := by sorry
