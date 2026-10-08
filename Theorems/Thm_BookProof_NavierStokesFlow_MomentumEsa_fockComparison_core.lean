-- Generated from ChapterNavierStokesMomentumEsa.lean — theorem BookProof.NavierStokesFlow.MomentumEsa.fockComparison_core
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa




open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

theorem BookProof.NavierStokesFlow.MomentumEsa.fockComparison_core (n : ℕ → ℝ) (x : maxDom (fockSymbol n)) (ε : ℝ) (hε : 0 < ε) :
    ∃ y : maxDom (fockSymbol n), (y : L2I Config) ∈ lpFiniteModes Config ∧
      ‖(y : L2I Config) - (x : L2I Config)‖ < ε ∧
        ‖diagMax (fockSymbol n) y - diagMax (fockSymbol n) x‖ < ε := by sorry
