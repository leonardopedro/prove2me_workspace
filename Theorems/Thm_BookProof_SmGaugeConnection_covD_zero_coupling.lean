-- Generated from ChapterSmGaugeConnection.lean — theorem BookProof.SmGaugeConnection.covD_zero_coupling
import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
open BookProof.SmGaugeConnection

variable {N d : ℕ}



open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section


theorem BookProof.SmGaugeConnection.covD_zero_coupling (k : Fin 3 → ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) (j : Fin 3) :
    covD k 0 T A j = (Complex.I * ((k j : ℝ) : ℂ)) • (1 : Matrix (Fin N) (Fin N) ℂ) := by sorry
