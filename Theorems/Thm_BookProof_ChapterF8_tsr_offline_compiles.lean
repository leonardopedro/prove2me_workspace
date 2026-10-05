-- Generated from ChapterF8.lean — theorem BookProof.ChapterF8.tsr_offline_compiles
import Mathlib
import Definitions.Def_ChapterF8
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow.FockManyMode
open BookProof.ChapterF8


noncomputable section

open scoped BigOperators

theorem BookProof.ChapterF8.tsr_offline_compiles {d k K₂ m : ℕ} (h : Fin d → Fin k) (g : Fin k → Fin K₂)
    (hg : Function.Injective g) :
    (∀ x : Fin d → ℝ, twoLevelHash h g x ∈ singleExcitation K₂) ∧
    (∀ (x : Fin d → ℝ) (j : Fin k),
      twoLevelHash h g x (Finsupp.single (g j) 1) = ((featureHash h x j : ℝ) : ℂ)) ∧
    Submodule.span ℂ (operatorBasis m) = ⊤ ∧
    (∀ M M' : ℕ, totalCost M d m K₂ k + offlineCost M' d k
      = totalCost M' d m K₂ k + offlineCost M d k) := by sorry
