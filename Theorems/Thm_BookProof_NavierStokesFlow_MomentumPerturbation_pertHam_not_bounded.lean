-- Generated from ChapterNavierStokesMomentumPerturbation.lean — theorem BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation

variable {ι : Type*}




open LpNat BookProof.FarisLavine IkebeKato


theorem BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_not_bounded :
    ¬ ∃ C : ℝ, ∀ x : maxDom linSymbol,
      ‖pertHam linSymbol (eState 0) (eState 1) x‖ ≤ C * ‖(x : L2I ℕ)‖ := by sorry
