-- Generated from ChapterNavierStokesMomentumEsa.lean — solution of BookProof.NavierStokesFlow.MomentumEsa.fockComparison_core
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_exists_finiteModes_graph_approx
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa





open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ → ℝ) (x : maxDom (fockSymbol n)) (ε : ℝ) (hε : 0 < ε) :
    ∃ y : maxDom (fockSymbol n), (y : L2I Config) ∈ lpFiniteModes Config ∧
      ‖(y : L2I Config) - (x : L2I Config)‖ < ε ∧
        ‖diagMax (fockSymbol n) y - diagMax (fockSymbol n) x‖ < ε := exists_finiteModes_graph_approx _ x ε hε
