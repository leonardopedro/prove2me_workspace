-- Generated from ChapterBayesInference.lean — solution of BookProof.ChapterBayesInference.exists_unitary_reproduces_posterior
import Mathlib
import Definitions.Def_ChapterBayesInference
import Theorems.Thm_BookProof_ChapterBayesInference_joint_nonneg
import Theorems.Thm_BookProof_ChapterBayesInference_joint_sum_one
open BookProof.ChapterBayesInference



open scoped BigOperators


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution
    (hprior : ∀ x, 0 ≤ prior x) (hprior_sum : ∑ x, prior x = 1)
    (hL : ∀ x y, 0 ≤ L x y) (hL_row : ∀ x, ∑ y, L x y = 1)
    (i₀ : X × Y) :
    ∃ U : Matrix (X × Y) (X × Y) ℂ, U ∈ Matrix.unitaryGroup (X × Y) ℂ ∧
      (∀ x y, ‖U (x, y) i₀‖ ^ 2 = joint prior L x y) ∧
      ∀ y, 0 < evidence prior L y → ∀ x,
        posterior prior L y x =
          ‖U (x, y) i₀‖ ^ 2 / ∑ x', ‖U (x', y) i₀‖ ^ 2 := by

  have h_unitary_joint := BookProof.ChapterJointUnitary.exists_unitary_joint (fun x y => joint prior
      L x y) (fun x y => joint_nonneg hprior hL x y) (joint_sum_one hprior_sum hL_row) i₀;
  obtain ⟨ U, hU₁, hU₂ ⟩ := h_unitary_joint; use U; aesop;
