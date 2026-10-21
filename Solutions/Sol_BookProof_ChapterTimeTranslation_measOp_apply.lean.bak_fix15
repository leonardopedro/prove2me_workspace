-- Generated from ChapterTimeTranslation.lean — solution of BookProof.ChapterTimeTranslation.measOp_apply
import Mathlib
import Definitions.Def_ChapterTimeTranslation
open BookProof.ChapterTimeTranslation



open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (k l : Fin n) :
    measOp U a k l = U k a * (starRingEnd ℂ) (U l a) := by

  unfold measOp;
  simp only [proj, mul_apply, of_apply, mul_ite, mul_one, mul_zero, conjTranspose_apply,
      RCLike.star_def];
  rw [ Finset.sum_eq_single a ] <;> aesop
