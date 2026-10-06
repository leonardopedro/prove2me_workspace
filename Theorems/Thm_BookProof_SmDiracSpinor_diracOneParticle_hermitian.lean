-- Generated from ChapterSmDiracSpinor.lean — theorem BookProof.SmDiracSpinor.diracOneParticle_hermitian
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian
open BookProof.SmDiracSpinor

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}



open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section


theorem BookProof.SmDiracSpinor.diracOneParticle_hermitian :
    (diracOneParticle k m1 m2).conjTranspose = diracOneParticle k m1 m2 := by sorry
