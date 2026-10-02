-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_diagOp_one
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_add
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    (diagComparisonData d p q).comparison
      = diagOp (fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1) := by

  have hmom : (∑ i, ((diagComparisonData d p q).mom i).comp
      ((diagComparisonData d p q).mom i)) = diagOp (fun k => ∑ i, p i k ^ 2) := by
    have hcomp : ∀ i : Fin d, ((diagComparisonData d p q).mom i).comp
        ((diagComparisonData d p q).mom i) = diagOp (fun k => p i k ^ 2) := by
      intro i
      refine (FullEsa.diagOp_comp (p i) (p i)).trans ?_
      simp [sq]
    rw [Finset.sum_congr rfl fun i _ => hcomp i]
    exact (FullEsa.diagOp_sum (Finset.univ : Finset (Fin d)) fun i k => p i k ^ 2).trans rfl
  have hdrift : (∑ i, ((diagComparisonData d p q).drift i).comp
      ((diagComparisonData d p q).drift i)) = diagOp (fun k => ∑ i, q i k ^ 2) := by
    have hcomp : ∀ i : Fin d, ((diagComparisonData d p q).drift i).comp
        ((diagComparisonData d p q).drift i) = diagOp (fun k => q i k ^ 2) := by
      intro i
      refine (FullEsa.diagOp_comp (q i) (q i)).trans ?_
      simp [sq]
    rw [Finset.sum_congr rfl fun i _ => hcomp i]
    exact (FullEsa.diagOp_sum (Finset.univ : Finset (Fin d)) fun i k => q i k ^ 2).trans rfl
  rw [ComparisonData.comparison, hmom, hdrift]
  have 
