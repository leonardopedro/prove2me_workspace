-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.diagOp_norm_le
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


theorem BookProof.SmDiracYukawa.diagOp_norm_le {d : Finset (Fin n) → ℝ} {Om : ℝ} (hOm : 0 ≤ Om)
    (hd : ∀ S, |d S| ≤ Om) (ψ : FermiFock n) : ‖diagOp d ψ‖ ≤ Om * ‖ψ‖ := by sorry
