-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffN_embedCore
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_velNcore_eq_diagMax
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_intertwined_nsDiffN
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
    ((nsDiffN mu (embedCore x) : polyGaussCore (d := 3)) : L2d 3)
      = velUnitary ((diagMax (velSym mu)
          (Submodule.inclusion (finiteModes_le_maxDom (velSym mu)) x) : L2I Vel)) := by

  rw [intertwined_nsDiffN mu x, embedCore_coe, ← velNcore_eq_diagMax]
