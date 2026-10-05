-- Generated from ChapterFreeFieldBornSignOrientationSubgroup.lean — solution of BookProof.ChapterFreeFieldBornSignOrientationSubgroup.orientationPreservingSigns_index
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationSubgroup
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignOrientationCard_natCard_orientationPreserving_flip
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup



open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationKernel
open BookProof.ChapterFreeFieldBornSignOrientationCard


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    (orientationPreservingSigns (n + 1)).index = 2 := by

  have h_card : Nat.card (orientationPreservingSigns (n + 1)) = 2 ^ n := by
    convert natCard_orientationPreserving_flip n using 1
    rfl
  have h_index :=
    AddSubgroup.card_mul_index (orientationPreservingSigns (n + 1))
  simp_all [pow_succ']
  nlinarith [pow_pos (zero_lt_two' ℕ) n]
