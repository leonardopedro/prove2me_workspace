-- Generated from ChapterSmDiracSpinor.lean — theorem BookProof.SmDiracSpinor.diracOneParticle_sq
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian
open BookProof.SmDiracSpinor



open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}


theorem BookProof.SmDiracSpinor.diracOneParticle_sq :
    diracOneParticle k m1 m2 * diracOneParticle k m1 m2
      = (((∑ j : Fin 3, (k j : ℂ) ^ 2) + (m1 : ℂ) ^ 2 + (m2 : ℂ) ^ 2))
        • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
