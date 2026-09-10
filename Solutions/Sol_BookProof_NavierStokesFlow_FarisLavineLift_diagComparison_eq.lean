-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_diagOp_one
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)











open LpNat DiagonalEsa

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    (diagComparisonData d p q).comparison
      = diagOp (fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1) := by

  have hmom : (∑ i, ((diagComparisonData d p q).mom i).comp
      ((diagComparisonData d p q).mom i)) = diagOp (fun k => ∑ i, p i k ^ 2) := by
    have hcomp : ∀ i : Fin d, ((diagComparisonData d p q).mom i).comp
        ((diagComparisonData d p q).mom i) = diagOp (fun k => p i k ^ 2) := by
      intro i
      rw [show ((diagComparisonData d p q).mom i) = diagOp (p i) from rfl,
        FullEsa.diagOp_comp]
      simp [sq]
    rw [Finset.sum_congr rfl fun i _ => hcomp i, FullEsa.diagOp_sum]
  have hdrift : (∑ i, ((diagComparisonData d p q).drift i).comp
      ((diagComparisonData d p q).drift i)) = diagOp (fun k => ∑ i, q i k ^ 2) := by
    have hcomp : ∀ i : Fin d, ((diagComparisonData d p q).drift i).comp
        ((diagComparisonData d p q).drift i) = diagOp (fun k => q i k ^ 2) := by
      intro i
      rw [show ((diagComparisonData d p q).drift i) = diagOp (q i) from rfl,
        FullEsa.diagOp_comp]
      simp [sq]
    rw [Finset.sum_congr rfl fun i _ => hcomp i, FullEsa.diagOp_sum]
  rw [ComparisonData.comparison, hmom, hdrift, diagOp_one, FullEsa.diagOp_add,
    FullEsa.diagOp_add]
