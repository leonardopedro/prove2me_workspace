-- Generated from ChapterSmGaugeConnection.lean — theorem BookProof.SmGaugeConnection.covD_conj
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


theorem BookProof.SmGaugeConnection.covD_conj {k : Fin 3 → ℝ} {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {A : Fin d → Fin 3 → ℝ} {U : Matrix (Fin N) (Fin N) ℂ} (hU : U * Uᴴ = 1) (j : Fin 3) :
    U * covD k g T A j * Uᴴ
      = Complex.I • (((k j : ℝ) : ℂ) • (1 : Matrix (Fin N) (Fin N) ℂ)
          + U * conn g T A j * Uᴴ) := by sorry
