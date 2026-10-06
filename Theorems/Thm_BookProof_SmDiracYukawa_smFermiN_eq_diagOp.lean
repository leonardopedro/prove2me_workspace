-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.smFermiN_eq_diagOp
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.SmCar
open BookProof.SmDiracYukawa

variable {n : ℕ}



open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine


noncomputable section

theorem BookProof.SmDiracYukawa.smFermiN_eq_diagOp (om : Fin n → ℝ) (c0 : ℝ) :
    smFermiN om c0 = diagOp (smFermiWeight om c0) := by sorry
