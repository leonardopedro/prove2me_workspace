-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.diracGaugeField_symmetric
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
import Theorems.Thm_BookProof_SmGaugeConnection_diracGaugeMat_conjTranspose
import Theorems.Thm_BookProof_SmCar_fermiBilin_symmetric
open BookProof.SmGaugeConnection




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}

variable {N d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {k : Fin 3 → ℝ} {m1 m2 g : ℝ}
    {T : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {A : Fin 8 → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a)
    (psi phi : FermiFock 12) :
    (inner ℂ (diracGaugeField k m1 m2 g T A psi) phi : ℂ)
      = inner ℂ psi (diracGaugeField k m1 m2 g T A phi) := by

  refine fermiBilin_symmetric ?_ psi phi
  rw [Matrix.conjTranspose_reindex, diracGaugeMat_conjTranspose hT]
