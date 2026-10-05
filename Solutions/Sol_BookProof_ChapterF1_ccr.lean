-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.ccr
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : annih ∘ₗ creat - creat ∘ₗ annih = LinearMap.id := by

  refine LinearMap.ext fun p => ?_
  change derivative (X * p) - X * derivative p = p
  simp [derivative_mul]
