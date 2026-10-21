-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffN_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_embedCore_surjective
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_nsDiffN_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coe
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (mu : ℝ) :
    SymmetricOn (polyGaussCore (d := 3))
      ((polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)) := by

  intro f g
  obtain ⟨x, rfl⟩ := embedCore_surjective f
  obtain ⟨y, rfl⟩ := embedCore_surjective g
  simp only [LinearMap.comp_apply, Submodule.subtype_apply]
  rw [nsDiffN_embedCore, nsDiffN_embedCore, embedCore_coe, embedCore_coe,
    velUnitary.inner_map_map, velUnitary.inner_map_map]
  exact diagMax_symmetricOn (velSym mu) (Submodule.inclusion (finiteModes_le_maxDom (velSym mu)) x)
    (Submodule.inclusion (finiteModes_le_maxDom (velSym mu)) y)
