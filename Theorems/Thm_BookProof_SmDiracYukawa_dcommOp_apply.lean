-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.dcommOp_apply
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

theorem BookProof.SmDiracYukawa.dcommOp_apply (H N : FermiFock n →ₗ[ℂ] FermiFock n) (ψ : FermiFock n) :
    dcommOp H N ψ = N (N (H ψ)) - N (H (N ψ)) - (N (H (N ψ)) - H (N (N ψ))) := by sorry
