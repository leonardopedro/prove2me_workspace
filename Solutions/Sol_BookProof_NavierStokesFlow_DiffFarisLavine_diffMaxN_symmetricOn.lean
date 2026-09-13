-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxN_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxEquiv_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_apply
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine














open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

















variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem solution (mu : ℝ) :
    SymmetricOn (diffMaxDom mu) (diffMaxN mu) := by

  intro z w
  obtain ⟨z', rfl⟩ := (diffMaxEquiv mu).surjective z
  obtain ⟨w', rfl⟩ := (diffMaxEquiv mu).surjective w
  rw [diffMaxN_apply, diffMaxN_apply, diffMaxEquiv_coe, diffMaxEquiv_coe,
    velUnitary.inner_map_map, velUnitary.inner_map_map]
  exact diagMax_symmetricOn (velSym mu) z' w'
