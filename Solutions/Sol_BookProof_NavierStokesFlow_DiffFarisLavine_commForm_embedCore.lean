-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.commForm_embedCore
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_nsDiffH_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_nsDiffN_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_canH_coe_velH
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes Vel) :
    commForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c))
        ((polyGaussCore (d := 3)).subtype.comp (nsDiffN (velMu A (seqConst c)))) (embedCore x)
      = commForm (velH A (seqConst c)) (diagMax (velSym (velMu A (seqConst c))))
          (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A (seqConst c)))) x) := by

  simp only [commForm, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [nsDiffH_embedCore, nsDiffN_embedCore, canH_coe_velH, velUnitary.inner_map_map,
    velUnitary.inner_map_map]
