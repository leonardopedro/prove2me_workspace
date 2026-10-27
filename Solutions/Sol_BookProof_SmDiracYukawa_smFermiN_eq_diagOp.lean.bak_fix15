-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.smFermiN_eq_diagOp
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmCar_fermiEnergy_apply
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (om : Fin n → ℝ) (c0 : ℝ) :
    smFermiN om c0 = diagOp (smFermiWeight om c0) := by

  refine LinearMap.ext fun ψ => ?_
  ext S
  simp [smFermiN, smFermiWeight, fermiEnergy_apply, add_mul]
