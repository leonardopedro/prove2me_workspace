-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.dcommOp_apply
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}
variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (H N : FermiFock n →ₗ[ℂ] FermiFock n) (ψ : FermiFock n) :
    dcommOp H N ψ = N (N (H ψ)) - N (H (N ψ)) - (N (H (N ψ)) - H (N (N ψ))) := by

  simp [dcommOp, Ring.lie_def]
