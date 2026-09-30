-- Generated from ChapterOperatorSeriesEsa.lean — theorem BookProof.OperatorSeries.seriesOp_commForm_le
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

theorem BookProof.OperatorSeries.seriesOp_commForm_le
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) {b : κ → ℝ} (hb : Summable b)
    (hcomm : ∀ (k : κ) (x : maxDom c),
      |commForm (T k) (diagMax c) x| ≤ b k * quadForm (diagMax c) x)
    (hq : ∀ x : maxDom c, 0 ≤ quadForm (diagMax c) x) (x : maxDom c) :
    |commForm (seriesOp T a hnorm ha) (diagMax c) x| ≤ (∑' k, b k) * quadForm (diagMax c) x := by sorry
