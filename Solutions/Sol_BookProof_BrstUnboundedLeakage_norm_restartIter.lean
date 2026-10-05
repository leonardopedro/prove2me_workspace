-- Generated from ChapterBrstUnboundedLeakage.lean — solution of BookProof.BrstUnboundedLeakage.norm_restartIter
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Theorems.Thm_BookProof_BrstUnboundedLeakage_restartGen_isSelfAdjoint
open BookProof.BrstUnboundedLeakage



open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)
variable (Vs : ℕ → Submodule ℂ H) [∀ i, FiniteDimensional ℂ (Vs i)] (hVs : ∀ i, Vs i ≤ T.domain)

set_option maxHeartbeats 1000000 in
theorem solution (τ : ℝ) (x : H) (n : ℕ) :
    ‖leakageIter (restartGen T Vs hVs) τ x n‖ = ‖x‖ := norm_leakageIter (fun i => restartGen_isSelfAdjoint T Vs hVs i) τ x n
