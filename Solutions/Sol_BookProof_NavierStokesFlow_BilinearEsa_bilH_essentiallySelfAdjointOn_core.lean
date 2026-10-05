-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.bilH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_deficiencyTrivialAt_bilH
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_nsH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) :
    EssentiallySelfAdjointOn (lpFiniteModes (ℕ × J)) (bilH κ) :=
  ⟨deficiencyTrivialAt_bilH κ hκ Complex.I
        fun j => (nsH_essentiallySelfAdjointOn_core (hκ j)).1,
     deficiencyTrivialAt_bilH κ hκ (-Complex.I)
        fun j => (nsH_essentiallySelfAdjointOn_core (hκ j)).2⟩
