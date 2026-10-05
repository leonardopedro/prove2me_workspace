-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.gradedSecondQuantization_friedrichs
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_gradedHamiltonian_friedrichs_extension
import Theorems.Thm_BookProof_FockSecondQuantization_isHermCol_opCol
import Theorems.Thm_BookProof_FockSecondQuantization_isPosCol_opCol
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {F G : Type*}
    [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    [NormedAddCommGroup G] [InnerProductSpace ℂ G]
    (bB : HilbertBasis ℕ ℂ F) (bF : HilbertBasis ℕ ℂ G)
    (A : finiteModeDomain bB →ₗ[ℂ] finiteModeDomain bB)
    (B : finiteModeDomain bF →ₗ[ℂ] finiteModeDomain bF)
    (hA : SymmetricOn (finiteModeDomain bB) ((finiteModeDomain bB).subtype.comp A))
    (hAp : ∀ x, 0 ≤ quadForm ((finiteModeDomain bB).subtype.comp A) x)
    (hB : SymmetricOn (finiteModeDomain bF) ((finiteModeDomain bF).subtype.comp B))
    (hBp : ∀ x, 0 ≤ quadForm ((finiteModeDomain bF).subtype.comp B) x) :
    ∃ (Dom : Submodule ℂ GFock) (A' : Dom →ₗ[ℂ] GFock),
      IsPositiveSelfAdjointExtension
        (gradedHamiltonian (opCol bB A) (opCol bF B)) A' :=
  gradedHamiltonian_friedrichs_extension (isHermCol_opCol hA) (isPosCol_opCol hAp)
      (isHermCol_opCol hB) (isPosCol_opCol hBp)
