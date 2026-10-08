-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.diagOp_normSq
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.SmCar
open BookProof.SmDiracYukawa



open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section


theorem BookProof.SmDiracYukawa.diagOp_normSq (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    ‖diagOp d ψ‖ ^ 2 = ∑ S : Finset (Fin n), (d S) ^ 2 * ‖ψ S‖ ^ 2 := by sorry
