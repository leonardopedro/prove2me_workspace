-- Generated from ChapterSmDiracSpinor.lean — theorem BookProof.SmDiracSpinor.smFermiHam_zero_yukawa
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmCar
open BookProof.SmDiracYukawa
open BookProof.SmDiracSpinor

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}



open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section


theorem BookProof.SmDiracSpinor.smFermiHam_zero_yukawa (hD : Matrix (Fin 4) (Fin 4) ℂ) :
    smFermiHam hD (0 : Matrix (Fin 4) (Fin 4) ℂ) 0 = fermiBilin hD := by sorry
