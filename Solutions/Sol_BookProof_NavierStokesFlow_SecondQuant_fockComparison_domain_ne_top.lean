-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockComparison_domain_ne_top
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_norm_basis
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_fockCore_ne_top
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant



open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

set_option maxHeartbeats 1000000 in
theorem solution :
    (fockCore fiberCore : Submodule ℂ (lp fiberSector 2)) ≠ ⊤ :=
  fockCore_ne_top _ (fun _ => (basis 0 : L2N)) (fun _ => by
      simpa using norm_basis 0)
