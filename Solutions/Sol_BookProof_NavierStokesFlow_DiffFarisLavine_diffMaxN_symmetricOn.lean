-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxN_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxEquiv_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_apply
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_symmetricOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (mu : ℝ) :
    SymmetricOn (diffMaxDom mu) (diffMaxN mu) := by

  intro z w
  obtain ⟨z', rfl⟩ := (diffMaxEquiv mu).surjective z
  obtain ⟨w', rfl⟩ := (diffMaxEquiv mu).surjective w
  rw [diffMaxN_apply, diffMaxN_apply, diffMaxEquiv_coe, diffMaxEquiv_coe,
    velUnitary.inner_map_map, velUnitary.inner_map_map]
  exact diagMax_symmetricOn (velSym mu) z' w'
