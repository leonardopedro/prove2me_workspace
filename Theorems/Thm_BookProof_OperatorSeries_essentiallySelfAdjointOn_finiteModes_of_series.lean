-- Generated from ChapterOperatorSeriesEsa.lean — theorem BookProof.OperatorSeries.essentiallySelfAdjointOn_finiteModes_of_series
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









variable {ι : Type*} {c : ι → ℝ}

theorem BookProof.OperatorSeries.essentiallySelfAdjointOn_finiteModes_of_series {κ : Type*} (c : ι → ℝ)
    (hc : ∀ k, 0 ≤ c k) (T : κ → (maxDom c →ₗ[ℂ] L2I ι)) (a b : κ → ℝ)
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) (hb : Summable b) (hb0 : ∀ k, 0 ≤ b k)
    (hsym : ∀ k, SymmetricOn (maxDom c) (T k))
    (hcomm : ∀ (k : κ) (x : maxDom c),
      |commForm (T k) (diagMax c) x| ≤ b k * quadForm (diagMax c) x) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((seriesOp T a hnorm ha).comp (Submodule.inclusion (finiteModes_le_maxDom c))) := by sorry
