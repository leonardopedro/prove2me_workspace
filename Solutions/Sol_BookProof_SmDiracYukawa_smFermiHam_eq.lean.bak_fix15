-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.smFermiHam_eq
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmDiracYukawa_fermiBilin_add
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    smFermiHam hD M z = smDirac hD + smYukawa M z := by

  rw [smFermiHam, smFermiMatrix, fermiBilin_add, smDirac, smYukawa]
