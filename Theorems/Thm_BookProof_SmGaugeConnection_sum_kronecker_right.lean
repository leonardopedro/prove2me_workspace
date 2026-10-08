-- Generated from ChapterSmGaugeConnection.lean — theorem BookProof.SmGaugeConnection.sum_kronecker_right
import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
open BookProof.SmGaugeConnection



open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}


theorem BookProof.SmGaugeConnection.sum_kronecker_right {n : ℕ} (F : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (B : Matrix (Fin n) (Fin n) ℂ) : (∑ j : Fin 3, F j) ⊗ₖ B = ∑ j : Fin 3, (F j) ⊗ₖ B := by sorry
