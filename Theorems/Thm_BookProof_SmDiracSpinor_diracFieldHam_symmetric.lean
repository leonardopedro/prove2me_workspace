-- Generated from ChapterSmDiracSpinor.lean — theorem BookProof.SmDiracSpinor.diracFieldHam_symmetric
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmDiracSpinor

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}



open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section


theorem BookProof.SmDiracSpinor.diracFieldHam_symmetric (psi phi : FermiFock 4) :
    (inner ℂ (diracFieldHam k m1 m2 psi) phi : ℂ)
      = inner ℂ psi (diracFieldHam k m1 m2 phi) := by sorry
