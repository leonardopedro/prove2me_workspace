-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.diracGaugeMat_free
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
import Theorems.Thm_BookProof_SmGaugeConnection_diracGaugeMat_split
import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterSmDiracSpinor
open BookProof.SmGaugeConnection




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine
open BookProof.ChapterCPTHamiltonian
open BookProof.SmDiracSpinor

noncomputable section

variable {N d : ℕ}

variable {N d : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution (k : Fin 3 → ℝ) (m1 m2 g : ℝ)
    (T : Fin d → Matrix (Fin N) (Fin N) ℂ) :
    diracGaugeMat k m1 m2 g T (fun _ _ => (0 : ℝ))
      = diracOneParticle k m1 m2 ⊗ₖ (1 : Matrix (Fin N) (Fin N) ℂ) := by
  rw [diracGaugeMat_split]
  simp

/-! ## 5. Second quantization on the CAR algebra -/
