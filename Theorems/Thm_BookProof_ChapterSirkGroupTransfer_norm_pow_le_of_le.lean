-- Generated from ChapterSirkGroupTransfer.lean — theorem BookProof.ChapterSirkGroupTransfer.norm_pow_le_of_le
import Mathlib
import Definitions.Def_ChapterSirkGroupTransfer
open BookProof.ChapterSirkGroupTransfer


noncomputable section


open NormedSpace

variable {A : Type*} [NormedRing A] [NormOn

variable {A : Type*} [NormedRing A] [NormOneClass A] [NormedAlgebra ℂ A] [CompleteSpace A]

theorem BookProof.ChapterSirkGroupTransfer.norm_pow_le_of_le {a : A} {M : ℝ} (ha : ‖a‖ ≤ M) (n : ℕ) : ‖a ^ n‖ ≤ M ^ n := by sorry
