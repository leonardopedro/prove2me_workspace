-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.norm_dcommOp_le
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmDiracYukawa



open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

theorem BookProof.SmDiracYukawa.norm_dcommOp_le {H N : FermiFock n →ₗ[ℂ] FermiFock n} {K Om : ℝ}
    (hK : ∀ ψ, ‖H ψ‖ ≤ K * ‖ψ‖) (hN : ∀ ψ, ‖N ψ‖ ≤ Om * ‖ψ‖) (hKn : 0 ≤ K) (hOn : 0 ≤ Om)
    (ψ : FermiFock n) : ‖dcommOp H N ψ‖ ≤ 4 * K * Om ^ 2 * ‖ψ‖ := by sorry
