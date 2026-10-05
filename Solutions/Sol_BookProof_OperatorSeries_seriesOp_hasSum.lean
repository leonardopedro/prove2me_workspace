-- Generated from ChapterOperatorSeriesEsa.lean — solution of BookProof.OperatorSeries.seriesOp_hasSum
import Mathlib
import Definitions.Def_ChapterOperatorSeriesEsa
open BookProof.OperatorSeries




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι κ : Type*} {c : ι → ℝ}
variable (T : κ → (maxDom c →ₗ[ℂ] L2I ι)) (a : κ → ℝ)
variable {T} {a}

set_option maxHeartbeats 1000000 in
theorem solution
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) (x : maxDom c) :
    HasSum (fun k => (T k x : L2I ι)) (seriesOp T a hnorm ha x) := (summable_apply T a hnorm ha x).hasSum
