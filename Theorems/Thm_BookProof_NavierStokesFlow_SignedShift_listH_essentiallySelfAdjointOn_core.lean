-- Generated from ChapterNavierStokesSignedShift.lean — theorem BookProof.NavierStokesFlow.SignedShift.listH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift

variable {ι : Type*}
variable {sym : ι → ℝ} (S : SignedHop ι sym)
variable {sym : ι → ℝ}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian AffineFiber


theorem BookProof.NavierStokesFlow.SignedShift.listH_essentiallySelfAdjointOn_core (L : List (SignedHop ι sym)) (hsym : ∀ β, 1 ≤ sym β) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((listH L).comp (Submodule.inclusion (finiteModes_le_maxDom sym))) := by sorry
