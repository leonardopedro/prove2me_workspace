-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.hermiteMvLp_mem_range
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreEquiv_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coreState
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_pgLp_smul
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 3 →₀ ℕ) :
    hermiteMvLp a
      ∈ Submodule.map ((polyGaussCore (d := 3)).subtype) (LinearMap.range embedCore) := by

  refine ⟨embedCore (coreState (velIdx.symm a)), ⟨_, rfl⟩, ?_⟩
  rw [embedCore_coreState, Submodule.subtype_apply, coreEquiv_coe, pgLp_smul,
    Equiv.apply_symm_apply]
  rfl
