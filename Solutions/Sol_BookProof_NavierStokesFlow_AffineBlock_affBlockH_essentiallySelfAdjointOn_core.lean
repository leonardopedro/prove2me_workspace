-- Generated from ChapterNavierStokesAffineBlockEsa.lean — solution of BookProof.NavierStokesFlow.AffineBlock.affBlockH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineBlockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineBlock_deficiencyTrivialAt_affBlockH
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_affH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineBlock



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber BilinearEsa

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j)
    (hc : ∀ j, 0 ≤ c j) :
    EssentiallySelfAdjointOn (lpFiniteModes (ℕ × J)) (affBlockH κ c hκ hc) :=
  ⟨deficiencyTrivialAt_affBlockH κ c hκ hc Complex.I
        fun j => (affH_essentiallySelfAdjointOn_core (hκ j) (hc j)).1,
     deficiencyTrivialAt_affBlockH κ c hκ hc (-Complex.I)
        fun j => (affH_essentiallySelfAdjointOn_core (hκ j) (hc j)).2⟩
