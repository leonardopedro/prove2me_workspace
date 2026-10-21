-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.quadForm_nsDiffN_embedCore
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_nsDiffN_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coe
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (mu : ℝ) (x : lpFiniteModes Vel) :
    quadForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)) (embedCore x)
      = quadForm (diagMax (velSym mu))
          (Submodule.inclusion (finiteModes_le_maxDom (velSym mu)) x) := by

  simp only [quadForm, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [nsDiffN_embedCore, embedCore_coe, velUnitary.inner_map_map]
  rfl
