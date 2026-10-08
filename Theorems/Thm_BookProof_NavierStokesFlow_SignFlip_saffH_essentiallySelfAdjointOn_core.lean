-- Generated from ChapterNavierStokesSignFlip.lean — theorem BookProof.NavierStokesFlow.SignFlip.saffH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber.PairShift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

theorem BookProof.NavierStokesFlow.SignFlip.saffH_essentiallySelfAdjointOn_core {κ : ℝ} (hκ : 0 ≤ κ) (c : ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((saffH hκ c).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (affMu κ |c|))))) := by sorry
