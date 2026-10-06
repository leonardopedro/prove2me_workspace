-- Generated from ChapterSoftmaxBorn.lean — solution of BookProof.ChapterSoftmaxBorn.coherentBorn_temperature_half
import Mathlib
import Definitions.Def_ChapterSoftmaxBorn
import Theorems.Thm_BookProof_ChapterSoftmaxBorn_coherentBorn_eq_softmax
open BookProof.ChapterSoftmaxBorn



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r) (j : Fin m) :
    bornWeight q k j =
      Real.exp (inner ℝ q (k j) / (1 / 2)) / ∑ l, Real.exp (inner ℝ q (k l) / (1 / 2)) := by

  have hx : ∀ x : ℝ, x / (1 / 2) = 2 * x := fun x => by ring
  rw [coherentBorn_eq_softmax q k r hk j, softmax]
  simp only [hx]
