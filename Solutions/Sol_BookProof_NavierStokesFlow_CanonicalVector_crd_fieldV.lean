-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.crd_fieldV
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_add
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_pos
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_smul
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (x : lpFiniteModes Vel) :
    crd (fieldV A c i x) = vFun A c i (crd x) := by

  funext γ
  simp only [fieldV, vFun, LinearMap.add_apply, LinearMap.smul_apply, LinearMap.id_apply,
    Fin.sum_univ_three, crd_add, crd_smul, crd_pos, Pi.add_apply, Pi.smul_apply]
