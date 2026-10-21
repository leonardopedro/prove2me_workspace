-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.sblockH_essentiallySelfAdjointOn_core_inc
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_saffH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_deficiencyTrivialAt_sblockH
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber
open BookProof.NavierStokesFlow.AffineFiber.PairShift

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}
variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) :
    EssentiallySelfAdjointOn (lpFiniteModes (ℕ × J)) (sblockH κ c hκ) :=
  ⟨deficiencyTrivialAt_sblockH κ c hκ Complex.I
        fun j => (saffH_essentiallySelfAdjointOn_core (hκ j) (c j)).1,
     deficiencyTrivialAt_sblockH κ c hκ (-Complex.I)
        fun j => (saffH_essentiallySelfAdjointOn_core (hκ j) (c j)).2⟩
