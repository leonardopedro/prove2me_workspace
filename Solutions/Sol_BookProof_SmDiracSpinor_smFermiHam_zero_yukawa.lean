-- Generated from ChapterSmDiracSpinor.lean — solution of BookProof.SmDiracSpinor.smFermiHam_zero_yukawa
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
open BookProof.SmDiracSpinor




open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hD : Matrix (Fin 4) (Fin 4) ℂ) :
    smFermiHam hD (0 : Matrix (Fin 4) (Fin 4) ℂ) 0 = fermiBilin hD := by

  simp [smFermiHam, smFermiMatrix]
