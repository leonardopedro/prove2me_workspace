-- Generated from ChapterSmGaugeConnection.lean — theorem BookProof.SmGaugeConnection.sum_smul_reorg
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


theorem BookProof.SmGaugeConnection.sum_smul_reorg (x : Fin d → Fin d → ℂ) (y : Fin d → Fin d → Fin d → ℂ)
    (T : Fin d → Matrix (Fin N) (Fin N) ℂ) :
    ∑ a : Fin d, ∑ b : Fin d, x a b • (Complex.I • ∑ c : Fin d, y a b c • T c)
      = ∑ c : Fin d, (∑ a : Fin d, ∑ b : Fin d, Complex.I * (x a b * y a b c)) • T c := by sorry
