-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.canonical_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteCanonical_hamiltonian_eq
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_nsH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((lpFiniteModes ℕ).subtype.comp
        (((1 : ℂ) / 2) • ((mom κ).comp (drift κ) + (drift κ).comp (mom κ)))) := by

  rw [hamiltonian_eq hκ]
  exact nsH_essentiallySelfAdjointOn_core hκ
