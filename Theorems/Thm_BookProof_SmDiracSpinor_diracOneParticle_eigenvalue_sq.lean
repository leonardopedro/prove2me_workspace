-- Generated from ChapterSmDiracSpinor.lean — theorem BookProof.SmDiracSpinor.diracOneParticle_eigenvalue_sq
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
open BookProof.SmDiracSpinor



open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}


theorem BookProof.SmDiracSpinor.diracOneParticle_eigenvalue_sq {v : Fin 4 → ℂ} {mu : ℂ} (hv : v ≠ 0)
    (heig : (diracOneParticle k m1 m2).mulVec v = mu • v) :
    mu ^ 2 = (∑ j : Fin 3, (k j : ℂ) ^ 2) + (m1 : ℂ) ^ 2 + (m2 : ℂ) ^ 2 := by sorry
