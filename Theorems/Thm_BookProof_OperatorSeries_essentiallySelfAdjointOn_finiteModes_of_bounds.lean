-- Generated from ChapterOperatorSeriesEsa.lean — theorem BookProof.OperatorSeries.essentiallySelfAdjointOn_finiteModes_of_bounds
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

theorem BookProof.OperatorSeries.essentiallySelfAdjointOn_finiteModes_of_bounds (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k)
    (H : maxDom c →ₗ[ℂ] L2I ι) (A B : ℝ) (hB : 0 ≤ B) (hsym : SymmetricOn (maxDom c) H)
    (hA : ∀ x : maxDom c, ‖(H x : L2I ι)‖ ≤ A * ‖(diagMax c x : L2I ι)‖)
    (hcomm : ∀ x : maxDom c, |commForm H (diagMax c) x| ≤ B * quadForm (diagMax c) x) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom c))) := by sorry
